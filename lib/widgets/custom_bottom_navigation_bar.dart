import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomBottomNavigationBar - A customizable bottom navigation bar component
 * 
 * This component renders a bottom navigation bar with 5 predefined items:
 * Home, Search, Tournament (with special styling), Club, and Profile.
 * The Tournament item features a complex design with gradients and notification badge.
 * 
 * @param selectedIndex - Currently selected tab index (0-4)
 * @param onTap - Callback function when a tab is tapped, returns the index
 * @param notificationCount - Number to display in the tournament notification badge
 * @param backgroundColor - Background color of the bottom bar
 * @param shadowColor - Color of the drop shadow
 */
class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0,
    required this.onTap,
    this.notificationCount,
    this.backgroundColor,
    this.shadowColor,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? appTheme.whiteCustom,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Color(0xFFD0D1D3),
            blurRadius: 1.h,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(
            index: 0,
            icon: ImageConstant.imgNavTrangCh,
            label: "Trang chủ",
            isSelected: selectedIndex == 0,
          ),
          SizedBox(width: 42.h),
          _buildNavItem(
            index: 1,
            icon: ImageConstant.imgNavTMI,
            label: "Tìm đối",
            isSelected: selectedIndex == 1,
          ),
          SizedBox(width: 44.h),
          _buildTournamentItem(
            index: 2,
            isSelected: selectedIndex == 2,
          ),
          SizedBox(width: 44.h),
          _buildNavItem(
            index: 3,
            icon: ImageConstant.imgClb,
            label: "Club",
            isSelected: selectedIndex == 3,
            iconSize: 32.h,
          ),
          SizedBox(width: 54.h),
          _buildNavItem(
            index: 4,
            icon: ImageConstant.imgNavHS,
            label: "Hồ sơ",
            isSelected: selectedIndex == 4,
            iconSize: 18.h,
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
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 7.h),
          CustomImageView(
            imagePath: icon,
            height: iconSize ?? 20.h,
            width: iconSize ?? 20.h,
          ),
          SizedBox(height: _getGapForItem(index)),
          Text(
            label,
            style: _getTextStyleForItem(index, isSelected),
          ),
          SizedBox(height: 13.h),
        ],
      ),
    );
  }

  Widget _buildTournamentItem({
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42.h,
            height: 28.h,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    width: 36.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF3C0B43), Color(0xFFE220FD)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    width: 36.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF6987DE), Color(0xFF081E5F)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 3.h,
                  right: 3.h,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Center(
                      child: Container(
                        width: 24.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.34, -0.94),
                            end: Alignment(-0.34, 0.94),
                            colors: [Color(0xFF1A1919), Color(0xFF000000)],
                          ),
                          borderRadius: BorderRadius.circular(12.h),
                          boxShadow: [
                            BoxShadow(
                              color: appTheme.color990000,
                              blurRadius: 8.h,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: notificationCount !=
                                null // Modified: Fixed conditional widget rendering syntax
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteCustom,
                                  borderRadius: BorderRadius.circular(6.h),
                                ),
                                child: Text(
                                  notificationCount.toString(),
                                  style: TextStyleHelper
                                      .instance.label8RegularABeeZee
                                      .copyWith(height: 1.25),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Giải đấu",
            style: TextStyleHelper.instance.label10RegularRambla
                .copyWith(height: 1.3),
          ),
          SizedBox(height: 13.h),
        ],
      ),
    );
  }

  double _getGapForItem(int index) {
    switch (index) {
      case 0:
        return 4.h;
      case 1:
      case 4:
        return 2.h;
      default:
        return 3.h;
    }
  }

  TextStyle _getTextStyleForItem(int index, bool isSelected) {
    switch (index) {
      case 0:
        return TextStyleHelper.instance.label10RegularABeeZee
            .copyWith(height: 1.2);
      case 1:
        return TextStyleHelper.instance.label10RegularRambla
            .copyWith(color: appTheme.blue_gray_400, height: 1.3);
      case 3:
        return TextStyleHelper.instance.label10RegularRambla
            .copyWith(color: appTheme.gray_800, height: 1.3);
      case 4:
        return TextStyleHelper.instance.label10RegularRambla
            .copyWith(color: appTheme.gray_900, height: 1.3);
      default:
        return TextStyleHelper.instance.label10RegularRambla
            .copyWith(color: appTheme.blackCustom, height: 1.3);
    }
  }
}
