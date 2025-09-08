import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles
  // Large text styles typically used for headers and hero elements

  TextStyle get display50BlackAlumniSans => TextStyle(
        fontSize: 50.fSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'Alumni Sans',
        color: appTheme.whiteCustom,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title23SemiBoldRoboto => TextStyle(
        fontSize: 23.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: appTheme.indigo_900,
      );

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title18BoldRoboto => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: appTheme.blue_gray_800,
      );

  TextStyle get title17RegularABeeZee => TextStyle(
        fontSize: 17.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.black_900,
      );

  TextStyle get title16BoldRoboto => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: appTheme.blue_gray_800,
      );

  TextStyle get title16 => TextStyle(
        fontSize: 16.fSize,
        color: appTheme.cyan_900,
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14RegularInter => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: appTheme.color7F0000,
      );

  TextStyle get body14RegularNATS => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'NATS',
        color: appTheme.black_900,
      );

  TextStyle get body14RegularABeeZee => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.cyan_900,
      );

  TextStyle get body13RegularSFProText => TextStyle(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Pro Text',
        color: appTheme.color59FFFF,
      );

  TextStyle get body12RegularRoboto => TextStyle(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: appTheme.gray_900_01,
      );

  TextStyle get body12RegularAcme => TextStyle(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Acme',
        color: appTheme.black_900,
      );

  TextStyle get body12RegularInter => TextStyle(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: appTheme.cyan_900,
      );

  // Label Styles
  // Small text styles for labels, captions, and hints

  TextStyle get label10RegularRoboto => TextStyle(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        color: appTheme.cyan_900,
      );

  TextStyle get label10RegularRambla => TextStyle(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Rambla',
        color: appTheme.gray_500,
      );

  TextStyle get label10RegularABeeZee => TextStyle(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.blue_gray_400,
      );

  TextStyle get label8RegularABeeZee => TextStyle(
        fontSize: 8.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.blackCustom,
      );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get textStyle19 => TextStyle();
}
