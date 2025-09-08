import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import './custom_image_view.dart';

/// User Avatar Placeholder Widget
/// Displays user initials when profile image is not available
/// Follows Material Design 3 avatar specifications
class UserAvatarPlaceholder extends StatelessWidget {
  const UserAvatarPlaceholder({
    Key? key,
    required this.initials,
    this.size = 40.0,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  }) : super(key: key);

  /// User initials to display (e.g., "AL" for "Anh Long")
  final String initials;

  /// Size of the avatar circle
  final double size;

  /// Background color of the avatar circle
  final Color? backgroundColor;

  /// Text color for the initials
  final Color? textColor;

  /// Font size for the initials text
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? _getBackgroundColor();
    final effectiveTextColor = textColor ?? _getTextColor(effectiveBackgroundColor);
    final effectiveFontSize = fontSize ?? (size * 0.4);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: effectiveBackgroundColor,
        // Add subtle shadow for depth
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(
            color: effectiveTextColor,
            fontSize: effectiveFontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Generate background color based on initials for consistency
  Color _getBackgroundColor() {
    final hash = initials.hashCode;
    final colors = [
      appTheme.cyan_900,
      appTheme.blue_200,
      appTheme.indigo_300,
      appTheme.purple_A200,
      const Color(0xFF4CAF50), // Green
      const Color(0xFFF44336), // Red  
      const Color(0xFFFF9800), // Orange
      const Color(0xFF9C27B0), // Purple
    ];
    
    return colors[hash.abs() % colors.length];
  }

  /// Get contrasting text color based on background
  Color _getTextColor(Color backgroundColor) {
    // Calculate luminance to determine if we need light or dark text
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}

/// Avatar Widget with Fallback Support
/// Combines image loading with placeholder fallback
class AvatarWithFallback extends StatelessWidget {
  const AvatarWithFallback({
    Key? key,
    this.imageUrl,
    this.assetPath,
    required this.fullName,
    this.size = 40.0,
    this.onTap,
  }) : super(key: key);

  /// Network image URL (optional)
  final String? imageUrl;

  /// Local asset path (optional)
  final String? assetPath;

  /// Full name for generating initials
  final String fullName;

  /// Size of the avatar
  final double size;

  /// Tap callback
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: SizedBox(
          width: size,
          height: size,
          child: _buildAvatarContent(),
        ),
      ),
    );
  }

  Widget _buildAvatarContent() {
    // Generate initials for fallback
    final initials = _generateInitials(fullName);

    // Try to load network image first
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CustomImageView(
        imagePath: imageUrl!,
        height: size,
        width: size,
        fit: BoxFit.cover,
        placeHolder: assetPath,
        // Use initials placeholder on error
        // errorWidget: UserAvatarPlaceholder(
        //   initials: initials,
        //   size: size,
        // ),
      );
    }

    // Try to load asset image
    if (assetPath != null && assetPath!.isNotEmpty) {
      return CustomImageView(
        imagePath: assetPath!,
        height: size,
        width: size,
        fit: BoxFit.cover,
        // Use initials placeholder on error
        // errorWidget: UserAvatarPlaceholder(
        //   initials: initials,
        //   size: size,
        // ),
      );
    }

    // Default to initials placeholder
    return UserAvatarPlaceholder(
      initials: initials,
      size: size,
    );
  }

  String _generateInitials(String fullName) {
    if (fullName.isEmpty) return 'U';
    
    final names = fullName.trim().split(' ');
    if (names.length == 1) {
      return names[0].substring(0, 1);
    } else {
      return '${names[0].substring(0, 1)}${names[names.length - 1].substring(0, 1)}';
    }
  }
}
