import 'package:flutter/material.dart';

class AppColorsLocked {
  static const Color background = Color(0xFF121212); // أسود عميق للخلفية
  static const Color surface = Color(0xFF1E1E1E);    // رمادي غامق جداً للعناصر العائمة
  static const Color accent = Color(0xFF00E676);     // أخضر فسفوري رياضي
  static const Color textPrimary = Color(0xFFFFFFFF); // أبيض للنصوص الرئيسية
  static const Color textSecondary = Color(0xFFB3B3B3); // رمادي فاتح للنصوص الثانوية
}

final appThemeDataLocked = ThemeData(
  scaffoldBackgroundColor: AppColorsLocked.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColorsLocked.background,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(color: AppColorsLocked.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent, elevation: 0),
  useMaterial3: true,
);