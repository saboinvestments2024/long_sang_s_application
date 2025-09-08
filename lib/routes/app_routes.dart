import 'package:flutter/material.dart';
import '../presentation/club_profile_screen/club_profile_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String clubProfileScreen = '/club_profile_screen';
  static const String userProfileScreen = '/user_profile_screen';
  static const String userProfileScreenInitialPage =
      '/user_profile_screen_initial_page';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
        clubProfileScreen: (context) => ClubProfileScreen(),
        userProfileScreen: (context) => UserProfileScreen(),
        appNavigationScreen: (context) => AppNavigationScreen(),
        initialRoute: (context) => AppNavigationScreen()
      };
}
