// 🔧 COPILOT 2: User repository implementation
// Handles user data operations with both local and remote data sources

import '../../core/app_export.dart';

abstract class UserRepository {
  Future<RepositoryResult<User>> getCurrentUser();
  Future<RepositoryResult<User>> getUserById(String userId);
  Future<RepositoryResult<User>> getUserByUsername(String username);
  Future<RepositoryResult<User>> updateUser(User user);
  Future<RepositoryResult<List<User>>> searchUsers(String query);
  Future<RepositoryResult<UserStats>> getUserStats(String userId);
  Future<RepositoryResult<bool>> followUser(String userId);
  Future<RepositoryResult<bool>> unfollowUser(String userId);
}

class UserRepositoryImpl extends BaseRepository implements UserRepository {
  final SupabaseService _supabaseService;
  // final ApiService _apiService; // TODO: Will be used for external API calls

  UserRepositoryImpl({
    SupabaseService? supabaseService,
    ApiService? apiService,
  })  : _supabaseService = supabaseService ?? SupabaseService.instance;
        // _apiService = apiService ?? ApiService.instance;

  @override
  Future<RepositoryResult<User>> getCurrentUser() async {
    return safeCall(
      () async {
        // For now, return hardcoded current user
        // TODO: Replace with actual Supabase user data
        final currentUser = _supabaseService.currentUser;
        if (currentUser == null) {
          throw ApiException.auth(message: 'No authenticated user found');
        }

        // Temporary hardcoded data for current user
        return User.fromHardcodedData(
          id: currentUser.id,
          username: '@longsang',
          displayName: 'Anh Long Magic',
          avatarUrl: 'assets/images/img_user.png',
        ).copyWith(
          email: currentUser.email,
          stats: UserStats.fromHardcodedData(),
        );
      },
      operationName: 'get current user',
    );
  }

  @override
  Future<RepositoryResult<User>> getUserById(String userId) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase query
        // final response = await _supabaseService.client
        //     .from('users')
        //     .select()
        //     .eq('id', userId)
        //     .single();

        // For now, return hardcoded user data based on ID
        if (userId == 'user_001') {
          return User.fromHardcodedData(
            id: userId,
            username: '@longsang',
            displayName: 'Anh Long Magic',
            avatarUrl: 'assets/images/img_user.png',
          ).copyWith(stats: UserStats.fromHardcodedData());
        } else if (userId == 'user_002') {
          return User.fromHardcodedData(
            id: userId,
            username: '@sabo',
            displayName: 'SABO',
            avatarUrl: 'assets/images/img_club_avatar.png',
          ).copyWith(
            rank: UserRank.h,
            stats: UserStats.fromHardcodedData(
              elo: 1200,
              spa: 150,
              worldRanking: 150,
              totalMatches: 25,
            ),
          );
        }

        throw ApiException.server(
          message: 'User not found',
          statusCode: 404,
        );
      },
      operationName: 'get user by ID',
    );
  }

  @override
  Future<RepositoryResult<User>> getUserByUsername(String username) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase query
        // final response = await _supabaseService.client
        //     .from('users')
        //     .select()
        //     .eq('username', username)
        //     .single();

        // For now, return hardcoded user data based on username
        final cleanUsername = username.startsWith('@') ? username : '@$username';
        
        if (cleanUsername == '@longsang') {
          return User.fromHardcodedData(
            id: 'user_001',
            username: cleanUsername,
            displayName: 'Anh Long Magic',
            avatarUrl: 'assets/images/img_user.png',
          ).copyWith(stats: UserStats.fromHardcodedData());
        } else if (cleanUsername == '@sabo' || cleanUsername == '@sabobilliards') {
          return User.fromHardcodedData(
            id: 'user_002',
            username: cleanUsername,
            displayName: 'SABO',
            avatarUrl: 'assets/images/img_club_avatar.png',
          ).copyWith(
            rank: UserRank.h,
            stats: UserStats.fromHardcodedData(
              elo: 1200,
              spa: 150,
              worldRanking: 150,
              totalMatches: 25,
            ),
          );
        }

        throw ApiException.server(
          message: 'User not found',
          statusCode: 404,
        );
      },
      operationName: 'get user by username',
    );
  }

  @override
  Future<RepositoryResult<User>> updateUser(User user) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase update
        // final response = await _supabaseService.client
        //     .from('users')
        //     .update(user.toJson())
        //     .eq('id', user.id)
        //     .select()
        //     .single();

        // For now, return the updated user as-is
        return user.copyWith(updatedAt: DateTime.now());
      },
      operationName: 'update user',
    );
  }

  @override
  Future<RepositoryResult<List<User>>> searchUsers(String query) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase search
        // final response = await _supabaseService.client
        //     .from('users')
        //     .select()
        //     .textSearch('display_name', query);

        // For now, return filtered hardcoded users
        final allUsers = [
          User.fromHardcodedData(
            id: 'user_001',
            username: '@longsang',
            displayName: 'Anh Long Magic',
            avatarUrl: 'assets/images/img_user.png',
          ),
          User.fromHardcodedData(
            id: 'user_002',
            username: '@sabo',
            displayName: 'SABO',
            avatarUrl: 'assets/images/img_club_avatar.png',
          ),
        ];

        return allUsers
            .where((user) =>
                user.displayName?.toLowerCase().contains(query.toLowerCase()) == true ||
                user.username.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      operationName: 'search users',
    );
  }

  @override
  Future<RepositoryResult<UserStats>> getUserStats(String userId) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase query
        // final response = await _supabaseService.client
        //     .from('user_stats')
        //     .select()
        //     .eq('user_id', userId)
        //     .single();

        // For now, return hardcoded stats
        return UserStats.fromHardcodedData();
      },
      operationName: 'get user stats',
    );
  }

  @override
  Future<RepositoryResult<bool>> followUser(String userId) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase operation
        // await _supabaseService.client
        //     .from('user_follows')
        //     .insert({
        //       'follower_id': _supabaseService.currentUser!.id,
        //       'following_id': userId,
        //     });

        // For now, return success
        return true;
      },
      operationName: 'follow user',
    );
  }

  @override
  Future<RepositoryResult<bool>> unfollowUser(String userId) async {
    return safeCall(
      () async {
        // TODO: Replace with actual Supabase operation
        // await _supabaseService.client
        //     .from('user_follows')
        //     .delete()
        //     .eq('follower_id', _supabaseService.currentUser!.id)
        //     .eq('following_id', userId);

        // For now, return success
        return true;
      },
      operationName: 'unfollow user',
    );
  }
}
