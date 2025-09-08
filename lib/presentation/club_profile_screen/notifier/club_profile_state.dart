part of 'club_profile_notifier.dart';

class ClubProfileState extends Equatable {
  final ClubProfileModel? clubProfileModel;
  final List<MemberItemModel>? membersList;

  const ClubProfileState({
    this.clubProfileModel,
    this.membersList,
  });

  @override
  List<Object?> get props => [
        clubProfileModel,
        membersList,
      ];

  ClubProfileState copyWith({
    ClubProfileModel? clubProfileModel,
    List<MemberItemModel>? membersList,
  }) {
    return ClubProfileState(
      clubProfileModel: clubProfileModel ?? this.clubProfileModel,
      membersList: membersList ?? this.membersList,
    );
  }
}
