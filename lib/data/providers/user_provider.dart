// 🔧 COPILOT 2: User providers with Riverpod
// Provides user-related state management and data access

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_repository.dart';
import '../models/user_model.dart';
import '../../core/error/api_exception.dart';

// Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

// Current User Provider
final currentUserProvider = FutureProvider<User>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getCurrentUser();
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// User by ID Provider Family
final userByIdProvider = FutureProvider.family<User, String>((ref, userId) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getUserById(userId);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// User by Username Provider Family
final userByUsernameProvider = FutureProvider.family<User, String>((ref, username) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getUserByUsername(username);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// User Search Provider
final userSearchProvider = FutureProvider.family<List<User>, String>((ref, query) async {
  if (query.isEmpty) return <User>[];
  
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.searchUsers(query);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// User Stats Provider Family
final userStatsProvider = FutureProvider.family<UserStats, String>((ref, userId) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getUserStats(userId);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// User Actions Provider (for mutations)
final userActionsProvider = Provider<UserActions>((ref) {
  return UserActions(ref);
});

class UserActions {
  final Ref _ref;
  
  UserActions(this._ref);

  /// Update user profile
  Future<User> updateUser(User user) async {
    final repository = _ref.read(userRepositoryProvider);
    final result = await repository.updateUser(user);
    
    if (result.isSuccess) {
      // Invalidate related providers to refresh UI
      _ref.invalidate(currentUserProvider);
      _ref.invalidate(userByIdProvider(user.id));
      return result.data!;
    } else {
      throw result.error!;
    }
  }

  /// Follow a user
  Future<bool> followUser(String userId) async {
    final repository = _ref.read(userRepositoryProvider);
    final result = await repository.followUser(userId);
    
    if (result.isSuccess) {
      // Invalidate user data to refresh following status
      _ref.invalidate(userByIdProvider(userId));
      return result.data!;
    } else {
      throw result.error!;
    }
  }

  /// Unfollow a user
  Future<bool> unfollowUser(String userId) async {
    final repository = _ref.read(userRepositoryProvider);
    final result = await repository.unfollowUser(userId);
    
    if (result.isSuccess) {
      // Invalidate user data to refresh following status
      _ref.invalidate(userByIdProvider(userId));
      return result.data!;
    } else {
      throw result.error!;
    }
  }
}

// Helper extension for easier error handling in UI
extension UserAsyncValueX<T> on AsyncValue<T> {
  /// Get user-friendly error message
  String? get userFriendlyError {
    return when(
      data: (_) => null,
      loading: () => null,
      error: (error, _) {
        if (error is ApiException) {
          return error.userFriendlyMessage;
        }
        return 'Đã xảy ra lỗi không mong muốn';
      },
    );
  }

  /// Check if this async value has data
  bool get hasData => hasValue && value != null;

  /// Get data or null safely
  T? get dataOrNull => hasValue ? value : null;
}
