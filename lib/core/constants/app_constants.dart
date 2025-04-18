import 'package:flutter/material.dart';

class AppConstants {
  static ThemeData appTheme = ThemeData(
    primaryColor: const Color(0xFF4A90E2), // Мягкий синий
    scaffoldBackgroundColor: const Color(0xFFE8ECEF), // Тёплый серый
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF4A90E2),
      ),
    ),
  );
}
