// 🚀 GO_ROUTER ROUTE GUARDS
// Authentication and permission guards for protected routes

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mock authentication state provider
// TODO: Replace with real authentication when backend is integrated
final authStateProvider = StateProvider<bool>((ref) => true); // Default: authenticated

// Route guard for authenticated routes
class AuthGuard {
  static String? redirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    final isAuthenticated = ref.read(authStateProvider);
    
    // If not authenticated and trying to access protected route
    if (!isAuthenticated && _isProtectedRoute(state.matchedLocation)) {
      return '/login'; // Redirect to login (to be implemented)
    }
    
    return null; // No redirect needed
  }
  
  static bool _isProtectedRoute(String location) {
    // Define protected routes
    final protectedRoutes = [
      '/user-profile',
      '/club-profile', 
      '/tournament',
      '/settings',
      '/notifications'
    ];
    
    return protectedRoutes.any((route) => location.startsWith(route));
  }
}

// Permission-based route guard
class PermissionGuard {
  static String? redirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    // TODO: Implement permission checking when user roles are defined
    // Example: Check if user has club owner permissions for club management routes
    
    final location = state.matchedLocation;
    
    // Check club owner routes
    if (location.startsWith('/club-profile') && location.contains('/manage')) {
      // TODO: Check if user is club owner
      // if (!ref.read(userProvider).isClubOwner) return '/unauthorized';
    }
    
    return null; // No redirect needed for now
  }
}

// Route middleware for analytics and logging
class RouteMiddleware {
  static void onRouteChanged(BuildContext context, GoRouterState state) {
    // Log navigation for analytics
    debugPrint('📱 Navigation: ${state.matchedLocation}');
    
    // TODO: Send analytics event when analytics service is implemented
    // Analytics.trackScreenView(
    //   screenName: state.name ?? 'unknown',
    //   parameters: state.pathParameters,
    // );
  }
}

// Custom route information for better debugging
class RouteInfo {
  final String name;
  final String path;
  final Map<String, String> parameters;
  
  const RouteInfo({
    required this.name,
    required this.path,
    required this.parameters,
  });
  
  @override
  String toString() {
    return 'RouteInfo(name: $name, path: $path, parameters: $parameters)';
  }
}
