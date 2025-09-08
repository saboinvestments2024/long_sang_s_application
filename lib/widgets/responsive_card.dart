import 'package:flutter/material.dart';
import '../core/utils/responsive_helper.dart';

/**
 * ResponsiveCard - A card component that adapts to different screen sizes
 * 
 * This component automatically adjusts its layout, padding, and visual
 * properties based on the current screen size and device type.
 * 
 * Features:
 * - Automatic width adjustment based on device type
 * - Responsive padding and spacing
 * - Material Design 3 compliant elevation and styling
 * - Smooth transitions between layout changes
 * - Customizable aspect ratios per device type
 * - Built-in loading and error states
 * 
 * Usage:
 * ```dart
 * ResponsiveCard(
 *   child: YourContent(),
 *   title: "Card Title",
 *   onTap: () => handleTap(),
 * )
 * ```
 */
class ResponsiveCard extends StatefulWidget {
  const ResponsiveCard({
    Key? key,
    required this.child,
    this.title,
    this.subtitle,
    this.onTap,
    this.margin,
    this.elevation,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.backgroundColor,
    this.borderRadius,
    this.customWidth,
    this.aspectRatio,
  }) : super(key: key);

  final Widget child;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? customWidth;
  final double? aspectRatio;

  @override
  State<ResponsiveCard> createState() => _ResponsiveCardState();
}

class _ResponsiveCardState extends State<ResponsiveCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _elevationAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _animationController.reverse();
      widget.onTap!();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, deviceType) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: _getCardWidth(context, deviceType),
                margin: widget.margin ?? _getResponsiveMargin(context),
                child: _buildCard(context, deviceType),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, DeviceType deviceType) {
    if (widget.isLoading) {
      return _buildLoadingCard(context, deviceType);
    }
    
    if (widget.hasError) {
      return _buildErrorCard(context, deviceType);
    }
    
    return _buildNormalCard(context, deviceType);
  }

  Widget _buildNormalCard(BuildContext context, DeviceType deviceType) {
    final elevation = (widget.elevation ?? _getResponsiveElevation(deviceType)) 
        * _elevationAnimation.value;
    
    return Material(
      elevation: elevation,
      borderRadius: widget.borderRadius ?? _getResponsiveBorderRadius(deviceType),
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        borderRadius: widget.borderRadius ?? _getResponsiveBorderRadius(deviceType),
        child: Container(
          padding: _getResponsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null || widget.subtitle != null)
                _buildHeader(context, deviceType),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context, DeviceType deviceType) {
    return Material(
      elevation: _getResponsiveElevation(deviceType),
      borderRadius: widget.borderRadius ?? _getResponsiveBorderRadius(deviceType),
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: Container(
        padding: _getResponsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: deviceType == DeviceType.mobile ? 2 : 3,
            ),
            SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16, tablet: 20)),
            Text(
              "Đang tải...",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, DeviceType deviceType) {
    return Material(
      elevation: _getResponsiveElevation(deviceType),
      borderRadius: widget.borderRadius ?? _getResponsiveBorderRadius(deviceType),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Container(
        padding: _getResponsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: ResponsiveHelper.responsiveIconSize(context, mobile: 32, tablet: 40, desktop: 48),
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8, tablet: 12)),
            Text(
              widget.errorMessage ?? "Đã xảy ra lỗi",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.onTap != null) ...[
              SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 12, tablet: 16)),
              TextButton(
                onPressed: widget.onTap,
                child: Text("Thử lại"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DeviceType deviceType) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ResponsiveHelper.responsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: ResponsiveHelper.responsiveFontSize(
                  context, 
                  mobile: 16, 
                  tablet: 18, 
                  desktop: 20,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
          if (widget.subtitle != null) ...[
            SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 4, tablet: 6)),
            Text(
              widget.subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: ResponsiveHelper.responsiveFontSize(
                  context, 
                  mobile: 12, 
                  tablet: 13, 
                  desktop: 14,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  double _getCardWidth(BuildContext context, DeviceType deviceType) {
    if (widget.customWidth != null) {
      return widget.customWidth!;
    }
    
    return ResponsiveHelper.getCardWidth(context);
  }

  EdgeInsetsGeometry _getResponsiveMargin(BuildContext context) {
    return ResponsiveHelper.responsiveMargin(
      context,
      mobile: const EdgeInsets.all(8),
      tablet: const EdgeInsets.all(12),
      desktop: const EdgeInsets.all(16),
    );
  }

  EdgeInsetsGeometry _getResponsivePadding(BuildContext context) {
    return ResponsiveHelper.responsivePadding(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(20),
      desktop: const EdgeInsets.all(24),
    );
  }

  double _getResponsiveElevation(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 2;
      case DeviceType.tablet:
        return 3;
      case DeviceType.desktop:
        return 4;
    }
  }

  BorderRadius _getResponsiveBorderRadius(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return BorderRadius.circular(12);
      case DeviceType.tablet:
        return BorderRadius.circular(16);
      case DeviceType.desktop:
        return BorderRadius.circular(20);
    }
  }
}

/**
 * ResponsiveListTile - A responsive list item component
 * 
 * Adapts list tile styling and spacing based on screen size.
 */
class ResponsiveListTile extends StatelessWidget {
  const ResponsiveListTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isThreeLine = false,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isThreeLine;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, deviceType) {
        return ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
          isThreeLine: isThreeLine,
          contentPadding: _getContentPadding(context, deviceType),
          minVerticalPadding: _getMinVerticalPadding(deviceType),
          horizontalTitleGap: _getHorizontalTitleGap(deviceType),
        );
      },
    );
  }

  EdgeInsetsGeometry _getContentPadding(BuildContext context, DeviceType deviceType) {
    return ResponsiveHelper.responsivePadding(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tablet: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      desktop: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );
  }

  double _getMinVerticalPadding(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 8;
      case DeviceType.tablet:
        return 12;
      case DeviceType.desktop:
        return 16;
    }
  }

  double _getHorizontalTitleGap(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 16;
      case DeviceType.tablet:
        return 20;
      case DeviceType.desktop:
        return 24;
    }
  }
}
