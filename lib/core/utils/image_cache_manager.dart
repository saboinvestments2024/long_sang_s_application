import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

/// Custom cache manager for app images
/// Provides optimized caching with custom settings for performance
class AppImageCacheManager {
  static AppImageCacheManager? _instance;
  late CacheManager _cacheManager;

  static AppImageCacheManager get instance {
    _instance ??= AppImageCacheManager._internal();
    return _instance!;
  }

  AppImageCacheManager._internal() {
    _cacheManager = CacheManager(
      Config(
        'sang_app_image_cache',
        stalePeriod: const Duration(days: 7), // Cache for 7 days
        maxNrOfCacheObjects: 200, // Max 200 cached images
        repo: JsonCacheInfoRepository(databaseName: 'sang_app_image_cache'),
        fileService: HttpFileService(),
      ),
    );
  }

  /// Get the cache manager instance
  CacheManager get cacheManager => _cacheManager;

  /// Clear all cached images
  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }

  /// Get cache size in bytes
  Future<int> getCacheSize() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = Directory('${tempDir.path}/sang_app_image_cache');
      
      if (cacheDir.existsSync()) {
        int size = 0;
        cacheDir.listSync(recursive: true).forEach((entity) {
          if (entity is File) {
            size += entity.lengthSync();
          }
        });
        return size;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// Remove specific image from cache
  Future<void> removeFromCache(String url) async {
    await _cacheManager.removeFile(url);
  }
}
