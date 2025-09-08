import '../models/user_profile_model.dart';
import '../models/tournament_card_model.dart';
import '../../../core/app_export.dart';

part 'user_profile_state.dart';

final userProfileNotifier =
    StateNotifierProvider.autoDispose<UserProfileNotifier, UserProfileState>(
  (ref) => UserProfileNotifier(
    UserProfileState(
      userProfileModel: UserProfileModel(),
    ),
  ),
);

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  UserProfileNotifier(UserProfileState state) : super(state) {
    initialize();
  }

  void initialize() {
    List<TournamentCardModel> tournaments = [
      TournamentCardModel(
        ballNumber: '8',
        title: 'SABO POOL 8 BALL',
        date: '07/09 - Thứ 7',
        participants: '0/16',
        level: 'K - I+',
        prize: '10 Million',
        networkCount: '2 Mạng',
      ),
      TournamentCardModel(
        ballNumber: '8',
        title: 'SABO POOL 8 BALL',
        date: '07/09 - Thứ 7',
        participants: '0/16',
        level: 'K - I+',
        prize: '10 Million',
        networkCount: '2 Mạng',
      ),
    ];

    state = state.copyWith(
      userProfileModel: state.userProfileModel?.copyWith(
        username: 'longsang',
        displayName: 'Anh Long Magic',
        rank: 'G',
        elo: '1485',
        spa: '320',
        xh: '#89',
        matches: '37',
        tournaments: tournaments,
      ),
    );
  }

  void selectTab(int index) {
    state = state.copyWith(selectedTabIndex: index);
  }

  void onTournamentTap(TournamentCardModel tournament) {
    // Handle tournament selection
    state = state.copyWith(
      selectedTournament: tournament,
    );
  }
}
