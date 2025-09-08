// 🔧 COPILOT 2: Club providers with Riverpod
// Provides club-related state management and data access

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/club_repository.dart';
import '../models/club_model.dart';
import '../../core/error/api_exception.dart';

// Repository Provider
final clubRepositoryProvider = Provider<ClubRepository>((ref) {
  return ClubRepositoryImpl();
});

// Club by ID Provider Family
final clubByIdProvider = FutureProvider.family<Club, String>((ref, clubId) async {
  final repository = ref.read(clubRepositoryProvider);
  final result = await repository.getClubById(clubId);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// Club by Username Provider Family
final clubByUsernameProvider = FutureProvider.family<Club, String>((ref, username) async {
  final repository = ref.read(clubRepositoryProvider);
  final result = await repository.getClubByUsername(username);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// User's Clubs Provider Family
final userClubsProvider = FutureProvider.family<List<Club>, String>((ref, userId) async {
  final repository = ref.read(clubRepositoryProvider);
  final result = await repository.getUserClubs(userId);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// Club Members Provider Family
final clubMembersProvider = FutureProvider.family<List<ClubMember>, String>((ref, clubId) async {
  final repository = ref.read(clubRepositoryProvider);
  final result = await repository.getClubMembers(clubId);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// Club Stats Provider Family
final clubStatsProvider = FutureProvider.family<ClubStats, String>((ref, clubId) async {
  final repository = ref.read(clubRepositoryProvider);
  final result = await repository.getClubStats(clubId);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// Club Search Provider
final clubSearchProvider = FutureProvider.family<List<Club>, String>((ref, query) async {
  if (query.isEmpty) return <Club>[];
  
  final repository = ref.read(clubRepositoryProvider);
  final result = await repository.searchClubs(query);
  
  if (result.isSuccess) {
    return result.data!;
  } else {
    throw result.error!;
  }
});

// Club Actions Provider (for mutations)
final clubActionsProvider = Provider<ClubActions>((ref) {
  return ClubActions(ref);
});

class ClubActions {
  final Ref _ref;
  
  ClubActions(this._ref);

  /// Join a club
  Future<bool> joinClub(String clubId) async {
    final repository = _ref.read(clubRepositoryProvider);
    final result = await repository.joinClub(clubId);
    
    if (result.isSuccess) {
      // Invalidate related providers to refresh UI
      _ref.invalidate(clubByIdProvider(clubId));
      _ref.invalidate(clubMembersProvider(clubId));
      _ref.invalidate(clubStatsProvider(clubId));
      return result.data!;
    } else {
      throw result.error!;
    }
  }

  /// Leave a club
  Future<bool> leaveClub(String clubId) async {
    final repository = _ref.read(clubRepositoryProvider);
    final result = await repository.leaveClub(clubId);
    
    if (result.isSuccess) {
      // Invalidate related providers to refresh UI
      _ref.invalidate(clubByIdProvider(clubId));
      _ref.invalidate(clubMembersProvider(clubId));
      _ref.invalidate(clubStatsProvider(clubId));
      return result.data!;
    } else {
      throw result.error!;
    }
  }

  /// Refresh club data
  void refreshClub(String clubId) {
    _ref.invalidate(clubByIdProvider(clubId));
    _ref.invalidate(clubMembersProvider(clubId));
    _ref.invalidate(clubStatsProvider(clubId));
  }

  /// Refresh all user clubs
  void refreshUserClubs(String userId) {
    _ref.invalidate(userClubsProvider(userId));
  }
}

// Helper extension for club-related async values
extension ClubAsyncValueX<T> on AsyncValue<T> {
  /// Get user-friendly error message for club operations
  String? get clubErrorMessage {
    return when(
      data: (_) => null,
      loading: () => null,
      error: (error, _) {
        if (error is ApiException) {
          switch (error.type) {
            case ApiExceptionType.auth:
              return 'Vui lòng đăng nhập để tham gia câu lạc bộ';
            case ApiExceptionType.server:
              if (error.statusCode == 404) {
                return 'Không tìm thấy câu lạc bộ';
              } else if (error.statusCode == 403) {
                return 'Bạn không có quyền truy cập câu lạc bộ này';
              }
              return 'Lỗi máy chủ. Vui lòng thử lại sau';
            case ApiExceptionType.network:
              return 'Không có kết nối mạng';
            default:
              return error.userFriendlyMessage;
          }
        }
        return 'Đã xảy ra lỗi không mong muốn';
      },
    );
  }

  /// Check if this async value has club data
  bool get hasClubData => hasValue && value != null;

  /// Get club data or null safely
  T? get clubDataOrNull => hasValue ? value : null;
}
