part of 'user_profile_notifier.dart';

class UserProfileState extends Equatable {
  final UserProfileModel? userProfileModel;
  final int selectedTabIndex;
  final TournamentCardModel? selectedTournament;

  const UserProfileState({
    this.userProfileModel,
    this.selectedTabIndex = 0,
    this.selectedTournament,
  });

  @override
  List<Object?> get props => [
        userProfileModel,
        selectedTabIndex,
        selectedTournament,
      ];

  UserProfileState copyWith({
    UserProfileModel? userProfileModel,
    int? selectedTabIndex,
    TournamentCardModel? selectedTournament,
  }) {
    return UserProfileState(
      userProfileModel: userProfileModel ?? this.userProfileModel,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedTournament: selectedTournament ?? this.selectedTournament,
    );
  }
}
