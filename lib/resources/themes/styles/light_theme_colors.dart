import 'package:flutter/material.dart';
import '/resources/themes/styles/color_styles.dart';

/*
|--------------------------------------------------------------------------
| Light Theme Colors
|--------------------------------------------------------------------------
*/

class LightThemeColors implements ColorStyles {
  // general
  Color get background => const Color(0xFFFFFFFF);

  Color get primaryContent => const Color(0xFF8C007E);
  Color get primaryAccent => const Color(0xFF6357F2);

  Color get surfaceBackground => Colors.white;
  Color get surfaceContent => const Color(0xFFCE730D);

  // app bar
  Color get appBarBackground => Colors.blue;
  Color get appBarPrimaryContent => Colors.white;

  // buttons
  Color get buttonBackground => Colors.blueAccent;
  Color get buttonPrimaryContent => Colors.white;
  Color get buttonLogout => const Color(0xffAA1212);

  // bottom tab bar
  Color get bottomTabBarBackground => Colors.white;

  // bottom tab bar - icons
  Color get bottomTabBarIconSelected => Colors.blue;
  Color get bottomTabBarIconUnselected => Colors.black54;

  // bottom tab bar - label
  Color get bottomTabBarLabelUnselected => Colors.black45;
  Color get bottomTabBarLabelSelected => Colors.black;
}
