
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1A182D),
    scaffoldBackgroundColor: const Color(0xFF1A182D),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFC8A2C8),
      secondary: Color(0xFF7ADFDD),
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Orbitron', color: Color(0xFFF0F0F0)),
      displayMedium: TextStyle(fontFamily: 'Orbitron', color: Color(0xFFF0F0F0)),
      displaySmall: TextStyle(fontFamily: 'Orbitron', color: Color(0xFFF0F0F0)),
      headlineMedium: TextStyle(fontFamily: 'Orbitron', color: Color(0xFFF0F0F0)),
      headlineSmall: TextStyle(fontFamily: 'Orbitron', color: Color(0xFFF0F0F0)),
      titleLarge: TextStyle(fontFamily: 'Orbitron', color: Color(0xFFF0F0F0)),
      bodyLarge: TextStyle(color: Color(0xFFF0F0F0)),
      bodyMedium: TextStyle(color: Color(0xFFF0F0F0)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0x991A182D), // Glassmorphism effect
      selectedItemColor: Color(0xFFC8A2C8),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFFF0F0F0),
        backgroundColor: const Color(0xFFC8A2C8).withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: const Color(0xFFC8A2C8),
        elevation: 5,
      ),
    ),
  );
}
