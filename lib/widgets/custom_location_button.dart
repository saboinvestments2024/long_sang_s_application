import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomLocationButton is a flexible button component that displays an optional left icon 
 * and text with customizable styling. Perfect for location-based UI elements or any button 
 * that needs an icon-text combination.
 * 
 * @param text - The button text content
 * @param leftIconPath - Optional path to the left icon (SVG/PNG)
 * @param backgroundColor - Background color of the button
 * @param textColor - Color of the button text
 * @param borderRadius - Border radius for rounded corners
 * @param fontSize - Font size of the button text
 * @param fontWeight - Font weight of the button text
 * @param fontFamily - Font family for the button text
 * @param onPressed - Callback function when button is pressed
 * @param padding - Internal padding of the button
 * @param iconSize - Size of the left icon
 */
class CustomLocationButton extends StatelessWidget {
  CustomLocationButton({
    Key? key,
    required this.text,
    this.leftIconPath,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.onPressed,
    this.padding,
    this.iconSize,
  }) : super(key: key);

  /// The text content displayed on the button
  final String text;

  /// Optional path to the left icon (SVG, PNG, or network image)
  final String? leftIconPath;

  /// Background color of the button
  final Color? backgroundColor;

  /// Text color of the button
  final Color? textColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Font size of the button text
  final double? fontSize;

  /// Font weight of the button text
  final FontWeight? fontWeight;

  /// Font family for the button text
  final String? fontFamily;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Internal padding of the button
  final EdgeInsets? padding;

  /// Size of the left icon
  final Size? iconSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(0x751E1E17),
        elevation: 0,
        padding: padding ??
            EdgeInsets.only(
              top: 6.h,
              right: 8.h,
              bottom: 6.h,
              left: 8.h,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5.h),
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIconPath != null) ...[
            CustomImageView(
              imagePath: leftIconPath!,
              width: iconSize?.width ?? 16.h,
              height: iconSize?.height ?? 22.h,
            ),
            SizedBox(width: 8.h),
          ],
          Text(
            text,
            style: TextStyleHelper.instance.textStyle19
                .copyWith(color: textColor ?? Color(0xFF081122), height: 1.19),
          ),
        ],
      ),
    );
  }
}
