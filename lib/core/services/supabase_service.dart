// 🔧 COPILOT 2: Supabase service initialization and management
// Handles Supabase client setup, authentication, and core database operations

import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';

class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();
  
  SupabaseService._();
  
  SupabaseClient? _client;
  SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase client not initialized. Call initialize() first.');
    }
    return _client!;
  }

  /// Initialize Supabase client
  Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
        debug: AppConfig.isDebugMode,
      );
      
      _client = Supabase.instance.client;
      
      if (AppConfig.enableLogging) {
        print('✅ Supabase initialized successfully');
      }
    } catch (e) {
      if (AppConfig.enableLogging) {
        print('❌ Failed to initialize Supabase: $e');
      }
      rethrow;
    }
  }

  /// Get current user
  User? get currentUser => _client?.auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (AppConfig.enableLogging) {
        print('✅ User signed in: ${response.user?.email}');
      }
      
      return response;
    } catch (e) {
      if (AppConfig.enableLogging) {
        print('❌ Sign in failed: $e');
      }
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );
      
      if (AppConfig.enableLogging) {
        print('✅ User signed up: ${response.user?.email}');
      }
      
      return response;
    } catch (e) {
      if (AppConfig.enableLogging) {
        print('❌ Sign up failed: $e');
      }
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
      
      if (AppConfig.enableLogging) {
        print('✅ User signed out');
      }
    } catch (e) {
      if (AppConfig.enableLogging) {
        print('❌ Sign out failed: $e');
      }
      rethrow;
    }
  }

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  /// Dispose resources
  void dispose() {
    _client = null;
    _instance = null;
  }
}
