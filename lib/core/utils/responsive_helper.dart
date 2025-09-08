import 'package:flutter/material.dart';

/// Device type enumeration
enum DeviceType { mobile, tablet, desktop }

/**
 * ResponsiveHelper - Comprehensive responsive design system for Flutter
 * 
 * This utility class provides a robust foundation for creating responsive layouts
 * that work seamlessly across mobile, tablet, and desktop screen sizes.
 * 
 * Features:
 * - Automatic device type detection
 * - Breakpoint-based responsive values
 * - Responsive spacing and sizing utilities
 * - Grid system with adaptive columns
 * - Orientation-aware layouts
 * - Context-aware responsive widgets
 * 
 * Breakpoints:
 * - Mobile: 0 - 600px
 * - Tablet: 600 - 1024px  
 * - Desktop: 1024px+
 * 
 * Usage:
 * ```dart
 * // Get responsive value
 * double fontSize = ResponsiveHelper.responsive(context,
 *   mobile: 14.0,
 *   tablet: 16.0,
 *   desktop: 18.0,
 * );
 * 
 * // Use responsive padding
 * EdgeInsets padding = ResponsiveHelper.responsivePadding(context,
 *   mobile: EdgeInsets.all(16),
 *   tablet: EdgeInsets.all(24),
 *   desktop: EdgeInsets.all(32),
 * );
 * 
 * // Check device type
 * if (ResponsiveHelper.isMobile(context)) {
 *   // Mobile-specific code
 * }
 * ```
 */
class ResponsiveHelper {
  // Breakpoint constants
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Get the current device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if the current device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if the current device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if the current device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Get responsive value based on device type
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Get responsive padding based on device type
  static EdgeInsets responsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive margin based on device type
  static EdgeInsets responsiveMargin(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive font size
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive icon size
  static double responsiveIconSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get responsive spacing
  static double responsiveSpacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get number of columns for grid layout
  static int getGridColumns(BuildContext context) {
    return responsive(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }

  /// Get aspect ratio for cards/items
  static double getAspectRatio(BuildContext context) {
    return responsive(
      context,
      mobile: 16 / 9,
      tablet: 4 / 3,
      desktop: 3 / 2,
    );
  }

  /// Get safe padding for different devices
  static EdgeInsets getSafePadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  /// Get responsive width percentage
  static double getWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  /// Get responsive height percentage
  static double getHeightPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  /// Get responsive container constraints
  static BoxConstraints getContainerConstraints(BuildContext context) {
    return BoxConstraints(
      maxWidth: responsive(
        context,
        mobile: double.infinity,
        tablet: 768,
        desktop: 1200,
      ),
    );
  }

  /// Get responsive card width
  static double getCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth - 32; // Full width minus padding
      case DeviceType.tablet:
        return (screenWidth - 48) / 2; // Half width minus padding
      case DeviceType.desktop:
        return (screenWidth - 64) / 3; // Third width minus padding
    }
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get responsive navigation rail width
  static double getNavigationRailWidth(BuildContext context) {
    return responsive(
      context,
      mobile: 0, // Hidden on mobile
      tablet: 72,
      desktop: 256,
    );
  }

  /// Get responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    return responsive(
      context,
      mobile: 56,
      tablet: 64,
      desktop: 72,
    );
  }

  /// Get responsive bottom navigation height
  static double getBottomNavigationHeight(BuildContext context) {
    return responsive(
      context,
      mobile: 72,
      tablet: 80,
      desktop: 0, // Hidden on desktop
    );
  }

  /// Get responsive modal width
  static double getModalWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return responsive(
      context,
      mobile: screenWidth * 0.9,
      tablet: 600,
      desktop: 800,
    );
  }

  /// Get responsive modal height
  static double getModalHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return responsive(
      context,
      mobile: screenHeight * 0.8,
      tablet: screenHeight * 0.7,
      desktop: screenHeight * 0.6,
    );
  }
}

/**
 * ResponsiveWidget - A wrapper widget that provides responsive functionality
 * 
 * This widget automatically rebuilds when screen size changes and provides
 * the current device type to its builder function.
 * 
 * Usage:
 * ```dart
 * ResponsiveWidget(
 *   builder: (context, deviceType) {
 *     switch (deviceType) {
 *       case DeviceType.mobile:
 *         return MobileLayout();
 *       case DeviceType.tablet:
 *         return TabletLayout();
 *       case DeviceType.desktop:
 *         return DesktopLayout();
 *     }
 *   },
 * )
 * ```
 */
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = ResponsiveHelper.getDeviceType(context);
        return builder(context, deviceType);
      },
    );
  }
}

/**
 * ResponsiveGridView - A responsive grid view that adapts column count
 * 
 * This widget automatically adjusts the number of columns based on screen size
 * and provides consistent spacing across different devices.
 */
class ResponsiveGridView extends StatelessWidget {
  const ResponsiveGridView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.childAspectRatio,
    this.padding,
    this.spacing = 16,
  }) : super(key: key);

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double? childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveHelper.responsive(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    final aspectRatio = childAspectRatio ?? ResponsiveHelper.getAspectRatio(context);

    return GridView.builder(
      padding: padding ?? ResponsiveHelper.getSafePadding(context),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
