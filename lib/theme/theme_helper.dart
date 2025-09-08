import 'package:flutter/material.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = "lightCode";

  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get gray_900 => Color(0xFF161722);
  Color get white_A700 => Color(0xFFFFFFFF);
  Color get blue_gray_100 => Color(0xFFD0D1D3);
  Color get indigo_900 => Color(0xFF18117B);
  Color get blue_gray_900 => Color(0xFF1A1A50);
  Color get indigo_900_26 => Color(0x2623195B);
  Color get blue_200 => Color(0xFFA0B2F8);
  Color get indigo_300 => Color(0xFF7792E2);
  Color get black_900 => Color(0xFF000000);
  Color get indigo_A100_66 => Color(0x667784F8);
  Color get gray_900_33 => Color(0x331B1A26);
  Color get deep_purple_A100_66 => Color(0x66C695F8);
  Color get gray_100 => Color(0xFFF5F5F5);
  Color get gray_900_01 => Color(0xFF071122);
  Color get blue_gray_800 => Color(0xFF445154);
  Color get gray_900_02 => Color(0xFF081122);
  Color get blue_gray_100_01 => Color(0xFFD7D7D9);
  Color get cyan_900 => Color(0xFF0A5C6D);
  Color get red_900 => Color(0xFF801515);
  Color get red_900_01 => Color(0xFF7F1516);
  Color get blue_gray_400 => Color(0xFF8A8B8F);
  Color get blue_gray_900_01 => Color(0xFF3C0B43);
  Color get purple_A200 => Color(0xFFE220FD);
  Color get indigo_300_01 => Color(0xFF6987DE);
  Color get indigo_900_01 => Color(0xFF081E5F);
  Color get gray_900_03 => Color(0xFF1A1919);
  Color get gray_500 => Color(0xFFA1A2A5);
  Color get gray_800 => Color(0xFF45454E);
  Color get red_900_02 => Color(0xFFBA1800);
  Color get indigo_900_1e => Color(0x1E1E1775);
  Color get gray_900_04 => Color(0xFF211A2C);
  Color get black_900_01 => Color(0xFF060606);
  Color get light_green_A700 => Color(0xFF5AD439);
  Color get blue_gray_400_01 => Color(0xFF86878B);

  // Additional Colors
  Color get transparentCustom => Colors.transparent;
  Color get whiteCustom => Colors.white;
  Color get blackCustom => Colors.black;
  Color get greyCustom => Colors.grey;
  Color get colorF86677 => Color(0xF8667784);
  Color get color26331B => Color(0x26331B1A);
  Color get colorF866C6 => Color(0xF866C695);
  Color get colorCC0000 => Color(0xCC000000);
  Color get color000000 => Color(0x00000000);
  Color get color59FFFF => Color(0x59FFFFFF);
  Color get color7F0000 => Color(0x7F000000);
  Color get color5B2623 => Color(0x5B262319);
  Color get color110000 => Color(0x11000000);
  Color get color3F0000 => Color(0x3F000000);
  Color get color990000 => Color(0x99000000);
  Color get color751E1E => Color(0x751E1E17);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
