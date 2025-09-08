import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomAppBar - A reusable app bar component with leading icon, username text, and trailing indicator
 * 
 * Features:
 * - Implements PreferredSizeWidget for proper AppBar integration
 * - Displays username with @ prefix
 * - Includes leading account icon and trailing rounded indicator
 * - Consistent shadow and styling across the app
 * - Responsive design using SizeUtils
 * 
 * @param username - The username text to display (without @ symbol)
 * @param leadingIconPath - Path to the leading icon SVG (optional)
 * @param showTrailingIndicator - Whether to show the trailing rounded indicator (optional)
 * @param onLeadingTap - Callback for leading icon tap (optional)
 */
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.username,
    this.leadingIconPath,
    this.showTrailingIndicator,
    this.onLeadingTap,
  }) : super(key: key);

  /// The username text to display with @ prefix
  final String username;

  /// Path to the leading icon SVG
  final String? leadingIconPath;

  /// Whether to show the trailing rounded indicator
  final bool? showTrailingIndicator;

  /// Callback function when leading icon is tapped
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appTheme.white_A700,
      elevation: 0,
      shadowColor: appTheme.blue_gray_100,
      surfaceTintColor: appTheme.transparentCustom,
      automaticallyImplyLeading: false,
      titleSpacing: 16.h,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onLeadingTap,
            child: CustomImageView(
              imagePath: leadingIconPath ?? ImageConstant.imgAddAccountIcon,
              height: 22.h,
              width: 22.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              "@$username",
              style: TextStyleHelper.instance.title17RegularABeeZee
                  .copyWith(color: appTheme.gray_900, height: 1.24),
            ),
          ),
          if (showTrailingIndicator ?? true)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                width: 18.h,
                height: 4.h,
                decoration: BoxDecoration(
                  color: appTheme.gray_900,
                  borderRadius: BorderRadius.circular(8.h),
                ),
              ),
            ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          height: 1.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: appTheme.blue_gray_100,
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(72.h);
}
