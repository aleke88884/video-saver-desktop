import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static ThemeData appTheme = ThemeData(
    primaryColor: const Color(0xFF4A90E2), // Мягкий синий
    fontFamily: GoogleFonts.montserrat().fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFE8ECEF), // Тёплый серый
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF4A90E2),
      ),
    ),
  );
  static const String videoTable = 'video_table';
}
