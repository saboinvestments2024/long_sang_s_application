// 🚀 GO_ROUTER ROUTE NAMES
// Centralized route name constants for type-safe navigation

class AppRouteNames {
  // Landing/Home routes
  static const String home = 'home';
  static const String appNavigation = 'app-navigation';
  
  // Profile routes  
  static const String clubProfile = 'club-profile';
  static const String userProfile = 'user-profile';
  static const String memberProfile = 'member-profile';
  
  // Tournament routes
  static const String tournamentDetails = 'tournament-details';
  static const String tournamentBracket = 'tournament-bracket';
  static const String tournamentList = 'tournament-list';
  
  // Feature routes (for future implementation)
  static const String search = 'search';
  static const String notifications = 'notifications';
  static const String settings = 'settings';
}

class AppRoutePaths {
  // Landing/Home paths
  static const String home = '/';
  static const String appNavigation = '/app-navigation';
  
  // Profile paths
  static const String clubProfile = '/club-profile/:clubId';
  static const String userProfile = '/user-profile/:userId';
  static const String memberProfile = '/member/:memberId';
  
  // Tournament paths
  static const String tournamentDetails = '/tournament/:tournamentId';
  static const String tournamentBracket = '/tournament/:tournamentId/bracket';
  static const String tournamentList = '/tournaments';
  
  // Feature paths (for future)
  static const String search = '/search';
  static const String notifications = '/notifications';  
  static const String settings = '/settings';
}

// Helper methods for building paths with parameters
class AppRouteBuilder {
  static String clubProfile(String clubId) => '/club-profile/$clubId';
  static String userProfile(String userId) => '/user-profile/$userId';
  static String memberProfile(String memberId) => '/member/$memberId';
  static String tournamentDetails(String tournamentId) => '/tournament/$tournamentId';
  static String tournamentBracket(String tournamentId) => '/tournament/$tournamentId/bracket';
}
