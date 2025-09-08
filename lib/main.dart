import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 🔧 COPILOT 2: Initialize backend services
  await _initializeServices();
  
  // 🚨 CRITICAL: Device orientation lock - DO NOT REMOVE
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]).then((value) {
    runApp(ProviderScope(child: MyApp()));
  });
}

/// Initialize all backend services
Future<void> _initializeServices() async {
  try {
    // Initialize API service
    ApiService.instance.initialize();
    
    // Initialize Supabase (commented out until configuration is ready)
    // await SupabaseService.instance.initialize();
    
    if (AppConfig.enableLogging) {
      print('✅ All services initialized successfully');
    }
  } catch (e) {
    if (AppConfig.enableLogging) {
      print('❌ Failed to initialize services: $e');
    }
    // Don't prevent app from running if services fail to initialize
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get GoRouter instance from provider
    final router = ref.watch(goRouterProvider);
    
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          routerConfig: router,
          theme: theme,
          title: 'long_sang_s_application',
          // 🚨 CRITICAL: NEVER REMOVE OR MODIFY
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
          // 🚨 END CRITICAL SECTION
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en', '')],
        );
      },
    );
  }
}
