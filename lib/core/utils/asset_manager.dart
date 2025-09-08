import 'package:flutter/material.dart';

/// Central asset management system
/// Provides organized access to all app assets with fallback mechanisms
class AssetManager {
  // User Avatar Assets
  static const String _avatarBasePath = 'assets/images/avatars/';
  static const String defaultUserAvatar = 'assets/images/img_user.png';
  static const String defaultClubAvatar = 'assets/images/img_club_avatar.png';

  // Club Photo Assets
  static const String _clubPhotosPath = 'assets/images/club_photos/';
  static const String defaultClubPhoto = 'assets/images/img_photo.png';

  // Tournament Banner Assets
  static const String _tournamentBannersPath = 'assets/images/tournament_banners/';
  static const String defaultTournamentBanner = 'assets/images/img_illlustration.png';

  /// Get user avatar with fallback
  static String getUserAvatar(String? userId) {
    if (userId == null || userId.isEmpty) {
      return defaultUserAvatar;
    }
    
    // Try to get specific user avatar
    final avatarPath = '${_avatarBasePath}user_$userId.png';
    return avatarPath; // In real app, check if file exists
  }

  /// Get club photo with fallback  
  static String getClubPhoto(String? clubId) {
    if (clubId == null || clubId.isEmpty) {
      return defaultClubPhoto;
    }
    
    final clubPhotoPath = '${_clubPhotosPath}club_$clubId.jpg';
    return clubPhotoPath;
  }

  /// Get tournament banner with fallback
  static String getTournamentBanner(String? tournamentId) {
    if (tournamentId == null || tournamentId.isEmpty) {
      return defaultTournamentBanner;
    }
    
    final bannerPath = '${_tournamentBannersPath}tournament_$tournamentId.jpg';
    return bannerPath;
  }

  /// Generate user initials for avatar placeholder
  static String generateInitials(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return 'U';
    }
    
    final names = fullName.trim().split(' ');
    if (names.length == 1) {
      return names[0].substring(0, 1).toUpperCase();
    } else {
      return '${names[0].substring(0, 1)}${names[names.length - 1].substring(0, 1)}'.toUpperCase();
    }
  }

  /// Check if an asset exists (simplified for demo)
  static bool assetExists(String assetPath) {
    // In a real implementation, you would check if the asset actually exists
    // For now, we'll assume all default assets exist
    return assetPath.contains('img_');
  }

  /// Get optimized image path based on screen density
  static String getOptimizedImagePath(String basePath, BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    
    if (devicePixelRatio >= 3.0) {
      // 3x density
      return basePath.replaceAll('.png', '@3x.png');
    } else if (devicePixelRatio >= 2.0) {
      // 2x density  
      return basePath.replaceAll('.png', '@2x.png');
    } else {
      // 1x density
      return basePath;
    }
  }
}
