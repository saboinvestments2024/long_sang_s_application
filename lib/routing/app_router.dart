// 🚀 GO_ROUTER CONFIGURATION
// Main router setup for SANG'S APPLICATION

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import existing screens
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/club_profile_screen/club_profile_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';

// Import route names
import 'route_names.dart';

// Global router provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutePaths.home,
    debugLogDiagnostics: true, // Enable for development
    routes: [
      // 🏠 HOME ROUTE
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const AppNavigationScreen(),
      ),
      
      // 📱 APP NAVIGATION (Alternative home)
      GoRoute(
        path: AppRoutePaths.appNavigation,
        name: AppRouteNames.appNavigation,
        builder: (context, state) => const AppNavigationScreen(),
      ),
      
      // 🏛️ CLUB PROFILE ROUTE
      GoRoute(
        path: AppRoutePaths.clubProfile,
        name: AppRouteNames.clubProfile,
        builder: (context, state) {
          // final clubId = state.pathParameters['clubId'] ?? 'default';
          // TODO: Pass clubId to ClubProfileScreen when constructor is updated
          return const ClubProfileScreen();
        },
      ),
      
      // 👤 USER PROFILE ROUTE  
      GoRoute(
        path: AppRoutePaths.userProfile,
        name: AppRouteNames.userProfile,
        builder: (context, state) {
          // final userId = state.pathParameters['userId'] ?? 'default';
          // TODO: Pass userId to UserProfileScreen when constructor is updated
          return const UserProfileScreen();
        },
      ),
      
      // 🏆 TOURNAMENT ROUTES (Future implementation)
      GoRoute(
        path: AppRoutePaths.tournamentDetails,
        name: AppRouteNames.tournamentDetails,
        builder: (context, state) {
          final tournamentId = state.pathParameters['tournamentId'] ?? '';
          // TODO: Implement TournamentDetailsScreen
          return Scaffold(
            appBar: AppBar(title: Text('Tournament $tournamentId')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tournament Details Screen'),
                  Text('Tournament ID: $tournamentId'),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        },
        routes: [
          // Tournament bracket sub-route
          GoRoute(
            path: '/bracket',
            name: AppRouteNames.tournamentBracket,
            builder: (context, state) {
              final tournamentId = state.pathParameters['tournamentId'] ?? '';
              // TODO: Implement Tournament Bracket Screen
              return Scaffold(
                appBar: AppBar(title: Text('Tournament $tournamentId Bracket')),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tournament Bracket Screen'),
                      Text('Tournament ID: $tournamentId'),
                      ElevatedButton(
                        onPressed: () => context.pop(),
                        child: Text('Go Back'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      
      // 👥 MEMBER PROFILE ROUTE (Future implementation)
      GoRoute(
        path: AppRoutePaths.memberProfile,
        name: AppRouteNames.memberProfile,
        builder: (context, state) {
          final memberId = state.pathParameters['memberId'] ?? '';
          // TODO: Implement MemberProfileScreen
          return Scaffold(
            appBar: AppBar(title: Text('Member Profile')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Member Profile Screen'),
                  Text('Member ID: $memberId'),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('404 - Page Not Found'),
            Text('Path: ${state.uri}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutePaths.home),
              child: Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Navigation helper methods
extension GoRouterExtension on GoRouter {
  // Type-safe navigation methods
  void goToClubProfile(String clubId) {
    go(AppRouteBuilder.clubProfile(clubId));
  }
  
  void goToUserProfile(String userId) {
    go(AppRouteBuilder.userProfile(userId));
  }
  
  void goToTournamentDetails(String tournamentId) {
    go(AppRouteBuilder.tournamentDetails(tournamentId));
  }
  
  void pushTournamentDetails(String tournamentId) {
    push(AppRouteBuilder.tournamentDetails(tournamentId));
  }
}
