import '../../../core/app_export.dart';
import '../models/club_profile_model.dart';
import '../models/member_item_model.dart';

part 'club_profile_state.dart';

final clubProfileNotifier =
    StateNotifierProvider.autoDispose<ClubProfileNotifier, ClubProfileState>(
  (ref) => ClubProfileNotifier(
    ClubProfileState(
      clubProfileModel: ClubProfileModel(),
      membersList: [],
    ),
  ),
);

class ClubProfileNotifier extends StateNotifier<ClubProfileState> {
  ClubProfileNotifier(ClubProfileState state) : super(state) {
    initialize();
  }

  void initialize() {
    final clubProfile = ClubProfileModel(
      membersCount: '25',
      tournamentsCount: '15',
      prizePool: '89.9 Tr',
      challengesCount: '37',
    );

    final members = [
      MemberItemModel(
        avatar: ImageConstant.imgUser,
        name: 'Anh Long Magic',
        rank: 'Rank G',
        date: '04/09/2025',
      ),
      MemberItemModel(
        avatar: ImageConstant.imgUserBlack90001,
        name: 'SABO',
        rank: 'Rank H',
        date: '04/09/2025',
      ),
    ];

    state = state.copyWith(
      clubProfileModel: clubProfile,
      membersList: members,
    );
  }

  void onEditButtonPressed() {
    // Handle edit button press
  }

  void onLocationButtonPressed() {
    // Handle location button press
  }
}
