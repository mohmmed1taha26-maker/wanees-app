import 'package:flutter/material.dart';

abstract final class AppColors {
  static const ink = Color(0xFF172B4D);
  static const navy = Color(0xFF203A5F);
  static const mint = Color(0xFFB8E3D2);
  static const aqua = Color(0xFF4F9D9D);
  static const cream = Color(0xFFF7F4ED);
  static const peach = Color(0xFFFFD8C2);
}

abstract final class AppTheme {
  static const fontFamily = 'Arial';
  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.aqua,
        brightness: brightness,
        surface: dark ? const Color(0xFF142238) : AppColors.cream,
      ),
      scaffoldBackgroundColor: dark ? const Color(0xFF101B2D) : AppColors.cream,
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? const Color(0xFF1B2B42) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
