import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData vibrantVioletTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF5F4FF), // 主背景：柔和白紫
    scaffoldBackgroundColor: const Color(0xFFF5F4FF),
    splashColor: Colors.white.withOpacity(0.2), // 點擊時的白色波紋
    highlightColor: Colors.transparent, // 移除高亮色（避免灰色）
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8E7CFF), // 主色：夢幻亮紫藍
      secondary: Color(0xFFBAA6FF), // 次色：偏粉的柔紫
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Orbitron',
        color: Color(0xFF2C3E50), // 深藍灰 - 文字主色
      ),
      displayMedium: TextStyle(
        fontFamily: 'Orbitron',
        color: Color(0xFF2C3E50),
      ),
      displaySmall: TextStyle(fontFamily: 'Orbitron', color: Color(0xFF2C3E50)),
      headlineMedium: TextStyle(
        fontFamily: 'Orbitron',
        color: Color(0xFF2C3E50),
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Orbitron',
        color: Color(0xFF2C3E50),
      ),
      titleLarge: TextStyle(fontFamily: 'Orbitron', color: Color(0xFF2C3E50)),
      bodyLarge: TextStyle(color: Color(0xFF2C3E50)),
      bodyMedium: TextStyle(color: Color(0xFF2C3E50)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFD6CCFF), // 淺紫底，無透明（去漸層）
      selectedItemColor: Color(0xFF8E7CFF),
      unselectedItemColor: Color(0xFF8E7CFF), // 不透明但可加濾鏡做差異
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF8E7CFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: const Color(0xFF6A6AFF),
        elevation: 6,
      ),
    ),
  );
}
