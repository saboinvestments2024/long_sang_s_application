// 🔧 COPILOT 2: Core configuration management
// Centralized configuration for environment variables and app settings

class AppConfig {
  // Supabase Configuration
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY', 
    defaultValue: 'your-anon-key-here',
  );

  // API Configuration
  static const String baseApiUrl = String.fromEnvironment(
    'BASE_API_URL',
    defaultValue: 'https://api.billiards-app.com',
  );

  // App Configuration
  static const String appName = 'SANG\'S BILLIARDS';
  static const String appVersion = '1.0.0';
  
  // Cache Configuration
  static const int cacheTimeoutMinutes = 30;
  static const int maxCacheSize = 100; // MB
  
  // Network Configuration
  static const int connectionTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;
  
  // Debug Configuration
  static const bool isDebugMode = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );
  
  static const bool enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );
}
