import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomIconButton - A customizable circular icon button widget
 * 
 * Features:
 * - Customizable size, colors, and border properties
 * - Support for any icon asset (SVG, PNG, etc.)
 * - Configurable margin and padding
 * - Material design ripple effects
 * - Responsive design with SizeUtils
 * 
 * @param onPressed - Callback function when button is tapped
 * @param iconPath - Asset path for the icon to display
 * @param size - Width and height of the button
 * @param backgroundColor - Background color of the button
 * @param borderColor - Color of the button border
 * @param borderWidth - Thickness of the border
 * @param padding - Internal padding around the icon
 * @param margin - External margin around the button
 * @param borderRadius - Corner radius of the button
 */
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.onPressed,
    this.iconPath,
    this.size,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.margin,
    this.borderRadius,
  }) : super(key: key);

  /// Callback function triggered when the button is tapped
  final VoidCallback? onPressed;

  /// Asset path for the icon to be displayed
  final String? iconPath;

  /// Width and height of the button
  final double? size;

  /// Background color of the button
  final Color? backgroundColor;

  /// Color of the button border
  final Color? borderColor;

  /// Thickness of the border
  final double? borderWidth;

  /// Internal padding around the icon
  final EdgeInsetsGeometry? padding;

  /// External margin around the button
  final EdgeInsetsGeometry? margin;

  /// Corner radius of the button
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? 52.h;
    final buttonBorderRadius = borderRadius ?? 26.h;
    final buttonPadding = padding ?? EdgeInsets.all(12.h);
    final buttonMargin = margin ?? EdgeInsets.zero;
    final buttonBackgroundColor = backgroundColor ?? Color(0xFFF5F5F5);
    final buttonBorderColor = borderColor ?? Color(0xFFFFFFFF);
    final buttonBorderWidth = borderWidth ?? 5.h;
    final buttonIconPath =
        iconPath ?? "assets/images/img_line_design_edit_line.svg";

    return Container(
      margin: buttonMargin,
      child: Material(
        color: appTheme.transparentCustom,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            padding: buttonPadding,
            decoration: BoxDecoration(
              color: buttonBackgroundColor,
              border: Border.all(
                color: buttonBorderColor,
                width: buttonBorderWidth,
              ),
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            child: CustomImageView(
              imagePath: buttonIconPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
