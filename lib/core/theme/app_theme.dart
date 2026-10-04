import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF050509);
  static const Color surface = Color(0xFF0B0B13);
  static const Color neonPurple = Color(0xFF9D4EDD);
  static const Color neonCyan = Color(0xFF00F5FF);
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFF9696A8);

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: neonPurple,
        secondary: neonCyan,
        surface: surface,
      ),
      fontFamily: 'Arial',
      useMaterial3: true,
    );
  }
}