import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomBottomNavigationBar - Enhanced customizable bottom navigation bar component
 * 
 * This component renders a bottom navigation bar with 5 predefined items:
 * Home, Search, Tournament (with special styling), Club, and Profile.
 * The Tournament item features a complex design with gradients and notification badge.
 * 
 * Features:
 * - Smooth page transition animations
 * - Material Design 3 state indicators
 * - Haptic feedback on interactions
 * - Customizable notification badges
 * - Ripple effects and smooth transitions
 * 
 * @param selectedIndex - Currently selected tab index (0-4)
 * @param onTap - Callback function when a tab is tapped, returns the index
 * @param notificationCount - Number to display in the tournament notification badge
 * @param backgroundColor - Background color of the bottom bar
 * @param shadowColor - Color of the drop shadow
 * @param animationDuration - Duration of transition animations
 */
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0,
    required this.onTap,
    this.notificationCount,
    this.backgroundColor,
    this.shadowColor,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  /// Currently selected tab index
  final int selectedIndex;

  /// Callback function when a tab is tapped
  final Function(int) onTap;

  /// Number to display in tournament notification badge
  final int? notificationCount;

  /// Background color of the bottom bar
  final Color? backgroundColor;

  /// Color of the drop shadow
  final Color? shadowColor;

  /// Duration of transition animations
  final Duration animationDuration;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  List<bool> _isPressed = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    if (widget.notificationCount != null && widget.notificationCount! > 0) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.notificationCount != oldWidget.notificationCount) {
      if (widget.notificationCount != null && widget.notificationCount! > 0) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onItemTap(int index) {
    setState(() {
      _isPressed[index] = true;
    });
    
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    
    // Haptic feedback
    HapticFeedback.lightImpact();
    
    // Delayed tap to allow animation
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onTap(index);
      setState(() {
        _isPressed[index] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? appTheme.whiteCustom,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? appTheme.black_900.withOpacity(0.25),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            icon: ImageConstant.imgNavTrangCh,
            label: "Trang chủ",
            isSelected: widget.selectedIndex == 0,
          ),
          _buildNavItem(
            index: 1,
            icon: ImageConstant.imgNavTMI,
            label: "Tìm kiếm",
            isSelected: widget.selectedIndex == 1,
          ),
          _buildTournamentItem(
            index: 2,
            isSelected: widget.selectedIndex == 2,
          ),
          _buildNavItem(
            index: 3,
            icon: ImageConstant.imgNavHS,
            label: "Câu lạc bộ",
            isSelected: widget.selectedIndex == 3,
          ),
          _buildNavItem(
            index: 4,
            icon: ImageConstant.imgUser,
            label: "Hồ sơ",
            isSelected: widget.selectedIndex == 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
    required bool isSelected,
    double? iconSize,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final bool shouldAnimate = _isPressed[index] && isSelected;
        
        return GestureDetector(
          onTap: () => _onItemTap(index),
          onTapDown: (_) => setState(() => _isPressed[index] = true),
          onTapUp: (_) => setState(() => _isPressed[index] = false),
          onTapCancel: () => setState(() => _isPressed[index] = false),
          child: AnimatedContainer(
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: isSelected ? 12.h : 8.h,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: isSelected 
                  ? appTheme.blue_gray_100.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 7.h),
                Transform.scale(
                  scale: shouldAnimate ? _scaleAnimation.value : 1.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(_isPressed[index] ? 2.h : 0),
                    child: CustomImageView(
                      imagePath: icon,
                      height: iconSize ?? 20.h,
                      width: iconSize ?? 20.h,
                      color: isSelected ? appTheme.blue_gray_900 : appTheme.gray_500,
                    ),
                  ),
                ),
                SizedBox(height: _getGapForItem(index)),
                AnimatedOpacity(
                  opacity: shouldAnimate ? _fadeAnimation.value : 1.0,
                  duration: widget.animationDuration,
                  child: Text(
                    label,
                    style: _getTextStyleForItem(index, isSelected),
                  ),
                ),
                SizedBox(height: 13.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTournamentItem({
    required int index,
    required bool isSelected,
  }) {
    return AnimatedBuilder(
      animation: Listenable.merge([_animationController, _pulseController]),
      builder: (context, child) {
        final bool shouldAnimate = _isPressed[index] && isSelected;
        final bool hasBadge = widget.notificationCount != null && widget.notificationCount! > 0;
        
        return GestureDetector(
          onTap: () => _onItemTap(index),
          onTapDown: (_) => setState(() => _isPressed[index] = true),
          onTapUp: (_) => setState(() => _isPressed[index] = false),
          onTapCancel: () => setState(() => _isPressed[index] = false),
          child: AnimatedContainer(
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: isSelected ? 8.h : 4.h,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: isSelected 
                  ? appTheme.blue_gray_100.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: shouldAnimate ? _scaleAnimation.value : 1.0,
                  child: Container(
                    width: 42.h,
                    height: 28.h,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 36.h,
                            height: 28.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.h),
                              gradient: LinearGradient(
                                begin: const Alignment(-0.5, -1),
                                end: const Alignment(0.5, 1),
                                colors: [
                                  appTheme.cyan_900,
                                  appTheme.blue_gray_100_01,
                                ],
                              ),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: appTheme.cyan_900.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ] : [],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(6.h),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgTournaments,
                                height: 16.h,
                                width: 16.h,
                              ),
                            ),
                          ),
                        ),
                        if (hasBadge)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 16.h,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  color: appTheme.red_900,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: appTheme.whiteCustom,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.notificationCount.toString(),
                                    style: TextStyle(
                                      color: appTheme.whiteCustom,
                                      fontSize: 8.h,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                AnimatedOpacity(
                  opacity: shouldAnimate ? _fadeAnimation.value : 1.0,
                  duration: widget.animationDuration,
                  child: Text(
                    "Giải đấu",
                    style: _getTextStyleForItem(index, isSelected),
                  ),
                ),
                SizedBox(height: 13.h),
              ],
            ),
          ),
        );
      },
    );
  }

  double _getGapForItem(int index) {
    switch (index) {
      case 0:
        return 8.h;
      case 1:
        return 8.h;
      case 3:
        return 8.h;
      case 4:
        return 8.h;
      default:
        return 4.h;
    }
  }

  TextStyle _getTextStyleForItem(int index, bool isSelected) {
    final baseStyle = TextStyleHelper.instance.body12RegularInter;
    final selectedColor = appTheme.blue_gray_900;
    final unselectedColor = appTheme.gray_500;
    
    return baseStyle.copyWith(
      color: isSelected ? selectedColor : unselectedColor,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      height: 1.2,
    );
  }
}
