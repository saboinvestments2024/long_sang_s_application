// 🔧 COPILOT 2: Club domain model
// Represents club entity in the domain layer

import 'package:equatable/equatable.dart';
import 'user_model.dart';

class Club extends Equatable {
  final String id;
  final String name;
  final String username;
  final String? description;
  final String? logoUrl;
  final String? coverImageUrl;
  final ClubLocation location;
  final ClubStats stats;
  final List<ClubMember> members;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  const Club({
    required this.id,
    required this.name,
    required this.username,
    this.description,
    this.logoUrl,
    this.coverImageUrl,
    required this.location,
    required this.stats,
    required this.members,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  /// Create club from hardcoded data (temporary)
  factory Club.fromHardcodedData() {
    return Club(
      id: 'club_001',
      name: 'SABO Billiards',
      username: '@sabobilliards',
      description: 'Câu lạc bộ Billiards chuyên nghiệp tại Vũng Tàu',
      logoUrl: 'assets/images/img_club_avatar.png',
      coverImageUrl: 'assets/images/img_illlustration.png',
      location: ClubLocation.fromHardcodedData(),
      stats: ClubStats.fromHardcodedData(),
      members: ClubMember.getHardcodedMembers(),
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      isActive: true,
    );
  }

  /// Copy with new values
  Club copyWith({
    String? id,
    String? name,
    String? username,
    String? description,
    String? logoUrl,
    String? coverImageUrl,
    ClubLocation? location,
    ClubStats? stats,
    List<ClubMember>? members,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Club(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      location: location ?? this.location,
      stats: stats ?? this.stats,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        description,
        logoUrl,
        coverImageUrl,
        location,
        stats,
        members,
        createdAt,
        updatedAt,
        isActive,
      ];
}

/// Club location information
class ClubLocation extends Equatable {
  final String address;
  final String? city;
  final String? province;
  final String? country;
  final double? latitude;
  final double? longitude;

  const ClubLocation({
    required this.address,
    this.city,
    this.province,
    this.country,
    this.latitude,
    this.longitude,
  });

  /// Create from hardcoded data
  factory ClubLocation.fromHardcodedData() {
    return const ClubLocation(
      address: '601A Nguyễn An Ninh',
      city: 'TP Vũng Tàu',
      province: 'Bà Rịa - Vũng Tàu',
      country: 'Việt Nam',
      latitude: 10.3460, // Approximate coordinates for Vũng Tàu
      longitude: 107.0844,
    );
  }

  /// Get formatted full address
  String get fullAddress {
    final parts = <String>[address];
    if (city != null) parts.add(city!);
    if (province != null) parts.add(province!);
    return parts.join(' - ');
  }

  @override
  List<Object?> get props => [
        address,
        city,
        province,
        country,
        latitude,
        longitude,
      ];
}

/// Club statistics
class ClubStats extends Equatable {
  final int totalMembers;
  final int totalTournaments;
  final double totalPrizePool; // in VND
  final int totalChallenges;
  final int activeTournaments;
  final int completedTournaments;

  const ClubStats({
    required this.totalMembers,
    required this.totalTournaments,
    required this.totalPrizePool,
    required this.totalChallenges,
    required this.activeTournaments,
    required this.completedTournaments,
  });

  /// Create from hardcoded data
  factory ClubStats.fromHardcodedData() {
    return const ClubStats(
      totalMembers: 25,
      totalTournaments: 15,
      totalPrizePool: 89900000, // 89.9M VND
      totalChallenges: 37,
      activeTournaments: 3,
      completedTournaments: 12,
    );
  }

  /// Format prize pool for display
  String get formattedPrizePool {
    if (totalPrizePool >= 1000000) {
      return '${(totalPrizePool / 1000000).toStringAsFixed(1)}M';
    } else if (totalPrizePool >= 1000) {
      return '${(totalPrizePool / 1000).toStringAsFixed(1)}K';
    }
    return totalPrizePool.toStringAsFixed(0);
  }

  @override
  List<Object?> get props => [
        totalMembers,
        totalTournaments,
        totalPrizePool,
        totalChallenges,
        activeTournaments,
        completedTournaments,
      ];
}

/// Club member information
class ClubMember extends Equatable {
  final String userId;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final UserRank rank;
  final ClubMemberRole role;
  final DateTime joinedAt;
  final bool isActive;

  const ClubMember({
    required this.userId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    required this.rank,
    required this.role,
    required this.joinedAt,
    this.isActive = true,
  });

  /// Get hardcoded members list
  static List<ClubMember> getHardcodedMembers() {
    return [
      ClubMember(
        userId: 'user_001',
        username: '@longsang',
        displayName: 'Anh Long Magic',
        avatarUrl: 'assets/images/img_user.png',
        rank: UserRank.g,
        role: ClubMemberRole.member,
        joinedAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
      ClubMember(
        userId: 'user_002',
        username: '@sabo',
        displayName: 'SABO',
        avatarUrl: 'assets/images/img_club_avatar.png',
        rank: UserRank.h,
        role: ClubMemberRole.admin,
        joinedAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
    ];
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        displayName,
        avatarUrl,
        rank,
        role,
        joinedAt,
        isActive,
      ];
}

/// Club member roles
enum ClubMemberRole {
  admin('Admin'),
  moderator('Moderator'),
  member('Member');

  const ClubMemberRole(this.displayName);
  final String displayName;
}
