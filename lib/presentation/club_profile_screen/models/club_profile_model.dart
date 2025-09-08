import '../../../core/app_export.dart';

/// This class is used in the [club_profile_screen] screen.

// ignore_for_file: must_be_immutable
class ClubProfileModel extends Equatable {
  ClubProfileModel({
    this.membersCount,
    this.tournamentsCount,
    this.prizePool,
    this.challengesCount,
  }) {
    membersCount = membersCount ?? '25';
    tournamentsCount = tournamentsCount ?? '15';
    prizePool = prizePool ?? '89.9 Tr';
    challengesCount = challengesCount ?? '37';
  }

  String? membersCount;
  String? tournamentsCount;
  String? prizePool;
  String? challengesCount;

  ClubProfileModel copyWith({
    String? membersCount,
    String? tournamentsCount,
    String? prizePool,
    String? challengesCount,
  }) {
    return ClubProfileModel(
      membersCount: membersCount ?? this.membersCount,
      tournamentsCount: tournamentsCount ?? this.tournamentsCount,
      prizePool: prizePool ?? this.prizePool,
      challengesCount: challengesCount ?? this.challengesCount,
    );
  }

  @override
  List<Object?> get props => [
        membersCount,
        tournamentsCount,
        prizePool,
        challengesCount,
      ];
}
