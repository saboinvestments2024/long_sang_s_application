import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            context.go(AppRoutePaths.home);
            break;
          case 1: // Search  
            // TODO: Implement search route
            context.go(AppRoutePaths.userProfile.replaceAll(':userId', 'current'));
            break;
          case 2: // Tournament
            // TODO: Implement tournament list route
            context.go(AppRoutePaths.userProfile.replaceAll(':userId', 'current'));
            break;
          case 3: // Club
            context.go(AppRoutePaths.clubProfile.replaceAll(':clubId', 'sabo'));
            break;
          case 4: // Profile
            context.go(AppRoutePaths.userProfile.replaceAll(':userId', 'current'));
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
