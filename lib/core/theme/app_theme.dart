// File: lib/core/theme/app_theme.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border({Color color = AppPalette.borderColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 3),
      );
  static final darkThemeMode = ThemeData().copyWith(
    appBarTheme: AppBarThemeData(
      foregroundColor: AppPalette.greyColor,
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      backgroundColor: AppPalette.backgroundColor,
    ),
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      color: WidgetStatePropertyAll(AppPalette.backgroundColor),
    ),
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.all(25),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(color: AppPalette.gradient2),
      errorBorder: _border(color: AppPalette.errorColor),
    ),
  );
}
