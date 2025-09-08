// 🔧 COPILOT 2: User domain model
// Represents user entity in the domain layer

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String? displayName;
  final String? email;
  final String? avatarUrl;
  final String? phoneNumber;
  final UserRank rank;
  final UserStats stats;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  const User({
    required this.id,
    required this.username,
    this.displayName,
    this.email,
    this.avatarUrl,
    this.phoneNumber,
    required this.rank,
    required this.stats,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  /// Create user from hardcoded data (temporary)
  factory User.fromHardcodedData({
    required String id,
    required String username,
    String? displayName,
    String? avatarUrl,
  }) {
    return User(
      id: id,
      username: username,
      displayName: displayName ?? username,
      avatarUrl: avatarUrl,
      rank: UserRank.g, // Default rank
      stats: UserStats.defaultStats(),
      createdAt: DateTime.now(),
      isActive: true,
    );
  }

  /// Copy with new values
  User copyWith({
    String? id,
    String? username,
    String? displayName,
    String? email,
    String? avatarUrl,
    String? phoneNumber,
    UserRank? rank,
    UserStats? stats,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      rank: rank ?? this.rank,
      stats: stats ?? this.stats,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        displayName,
        email,
        avatarUrl,
        phoneNumber,
        rank,
        stats,
        createdAt,
        updatedAt,
        isActive,
      ];
}

/// User ranking system
enum UserRank {
  s('S'),
  a('A'),
  b('B'),
  c('C'),
  d('D'),
  e('E'),
  f('F'),
  g('G'),
  h('H');

  const UserRank(this.displayName);
  final String displayName;

  /// Get rank color
  String get color {
    switch (this) {
      case UserRank.s:
        return '#FFD700'; // Gold
      case UserRank.a:
        return '#C0C0C0'; // Silver
      case UserRank.b:
        return '#CD7F32'; // Bronze
      case UserRank.c:
        return '#4CAF50'; // Green
      case UserRank.d:
        return '#2196F3'; // Blue
      case UserRank.e:
        return '#9C27B0'; // Purple
      case UserRank.f:
        return '#FF9800'; // Orange
      case UserRank.g:
        return '#F44336'; // Red
      case UserRank.h:
        return '#607D8B'; // Blue Grey
    }
  }

  /// Get rank from string
  static UserRank fromString(String rank) {
    return UserRank.values.firstWhere(
      (r) => r.displayName.toLowerCase() == rank.toLowerCase(),
      orElse: () => UserRank.h, // Default to lowest rank
    );
  }
}

/// User statistics
class UserStats extends Equatable {
  final int elo;
  final int spa;
  final int worldRanking;
  final int totalMatches;
  final int wonMatches;
  final int lostMatches;
  final double winRate;
  final int tournamentsPlayed;
  final int tournamentsWon;

  const UserStats({
    required this.elo,
    required this.spa,
    required this.worldRanking,
    required this.totalMatches,
    required this.wonMatches,
    required this.lostMatches,
    required this.winRate,
    required this.tournamentsPlayed,
    required this.tournamentsWon,
  });

  /// Create default stats for new users
  factory UserStats.defaultStats() {
    return const UserStats(
      elo: 1000,
      spa: 0,
      worldRanking: 9999,
      totalMatches: 0,
      wonMatches: 0,
      lostMatches: 0,
      winRate: 0.0,
      tournamentsPlayed: 0,
      tournamentsWon: 0,
    );
  }

  /// Create from hardcoded data
  factory UserStats.fromHardcodedData({
    int? elo,
    int? spa,
    int? worldRanking,
    int? totalMatches,
  }) {
    final matches = totalMatches ?? 37;
    final won = (matches * 0.65).round(); // Assume 65% win rate
    final lost = matches - won;
    
    return UserStats(
      elo: elo ?? 1485,
      spa: spa ?? 320,
      worldRanking: worldRanking ?? 89,
      totalMatches: matches,
      wonMatches: won,
      lostMatches: lost,
      winRate: matches > 0 ? won / matches : 0.0,
      tournamentsPlayed: 15,
      tournamentsWon: 3,
    );
  }

  /// Copy with new values
  UserStats copyWith({
    int? elo,
    int? spa,
    int? worldRanking,
    int? totalMatches,
    int? wonMatches,
    int? lostMatches,
    double? winRate,
    int? tournamentsPlayed,
    int? tournamentsWon,
  }) {
    return UserStats(
      elo: elo ?? this.elo,
      spa: spa ?? this.spa,
      worldRanking: worldRanking ?? this.worldRanking,
      totalMatches: totalMatches ?? this.totalMatches,
      wonMatches: wonMatches ?? this.wonMatches,
      lostMatches: lostMatches ?? this.lostMatches,
      winRate: winRate ?? this.winRate,
      tournamentsPlayed: tournamentsPlayed ?? this.tournamentsPlayed,
      tournamentsWon: tournamentsWon ?? this.tournamentsWon,
    );
  }

  /// Calculate win rate
  double calculateWinRate() {
    return totalMatches > 0 ? wonMatches / totalMatches : 0.0;
  }

  /// Format ELO for display
  String get formattedElo => elo.toString();

  /// Format SPA for display
  String get formattedSpa => spa.toString();

  /// Format world ranking for display
  String get formattedWorldRanking => '#$worldRanking XH';

  /// Format win rate as percentage
  String get formattedWinRate => '${(winRate * 100).toStringAsFixed(1)}%';

  @override
  List<Object?> get props => [
        elo,
        spa,
        worldRanking,
        totalMatches,
        wonMatches,
        lostMatches,
        winRate,
        tournamentsPlayed,
        tournamentsWon,
      ];
}
