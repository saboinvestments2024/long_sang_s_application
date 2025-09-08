import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../club_profile_screen/club_profile_screen.dart';
import './user_profile_screen_initial_page.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.userProfileScreenInitialPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, a1, a2) =>
                getCurrentPage(context, routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        child: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    int selectedIndex = 4; // Profile tab is active

    return CustomBottomNavigationBar(
      selectedIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0: // Home
            navigatorKey.currentState?.pushNamed(AppRoutes.userProfileScreen);
            break;
          case 1: // Search
            navigatorKey.currentState?.pushNamed(AppRoutes.userProfileScreen);
            break;
          case 2: // Tournament
            navigatorKey.currentState?.pushNamed(AppRoutes.userProfileScreen);
            break;
          case 3: // Club
            navigatorKey.currentState?.pushNamed(AppRoutes.clubProfileScreen);
            break;
          case 4: // Profile
            navigatorKey.currentState
                ?.pushNamed(AppRoutes.userProfileScreenInitialPage);
            break;
        }
      },
    );
  }

  Widget getCurrentPage(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.userProfileScreenInitialPage:
        return UserProfileScreenInitialPage();
      case AppRoutes.clubProfileScreen:
        return ClubProfileScreen();
      default:
        return UserProfileScreenInitialPage();
    }
  }
}
