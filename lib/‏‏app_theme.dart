import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const neonGreen    = Color(0xFF39FF14);
  static const neonGreenDim = Color(0x2639FF14);
  static const neonGreenMid = Color(0x5539FF14);

  static const darkBg           = Color(0xFF000000);
  static const darkCard         = Color(0xFF111111);
  static const darkCard2        = Color(0xFF1A1A1A);
  static const darkBorder       = Color(0xFF222222);
  static const darkText         = Color(0xFFFFFFFF);
  static const darkTextMuted    = Color(0xFF888888);
  static const darkTextSecondary= Color(0xFF555555);

  static const lightBg           = Color(0xFFFFFFFF);
  static const lightCard         = Color(0xFFF5F5F5);
  static const lightCard2        = Color(0xFFEEEEEE);
  static const lightBorder       = Color(0xFFDDDDDD);
  static const lightText         = Color(0xFF000000);
  static const lightTextMuted    = Color(0xFF666666);
  static const lightTextSecondary= Color(0xFF999999);

  static const red    = Color(0xFFFF3B30);
  static const orange = Color(0xFFFF9500);
  static const blue   = Color(0xFF007AFF);
}

class AppTheme {
  static BoxShadow neonGlow({double spread = 0, double blur = 12, double opacity = 0.5}) {
    return BoxShadow(
      color: AppColors.neonGreen.withOpacity(opacity),
      blurRadius: blur,
      spreadRadius: spread,
    );
  }

  static List<BoxShadow> neonGlowList({double blur = 14, double opacity = 0.45}) => [
    BoxShadow(color: AppColors.neonGreen.withOpacity(opacity),       blurRadius: blur),
    BoxShadow(color: AppColors.neonGreen.withOpacity(opacity * 0.4), blurRadius: blur * 2.5),
  ];

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.neonGreen,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGreen,
        surface: AppColors.darkCard,
        onPrimary: Colors.black,
        onSurface: AppColors.darkText,
      ),
      textTheme: _buildTextTheme(AppColors.darkText, AppColors.darkTextMuted),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.tajawal(
          fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.darkText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBg,
        selectedItemColor: AppColors.neonGreen,
        unselectedItemColor: AppColors.darkTextMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(                            // ✅ CardThemeData
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      dividerColor: AppColors.darkBorder,
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBg,
      primaryColor: AppColors.neonGreen,
      colorScheme: const ColorScheme.light(
        primary: AppColors.neonGreen,
        surface: AppColors.lightCard,
        onPrimary: Colors.black,
        onSurface: AppColors.lightText,
      ),
      textTheme: _buildTextTheme(AppColors.lightText, AppColors.lightTextMuted),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.tajawal(
          fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.lightText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBg,
        selectedItemColor: AppColors.neonGreen,
        unselectedItemColor: AppColors.lightTextMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(                            // ✅ CardThemeData
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      dividerColor: AppColors.lightBorder,
    );
  }

  static TextTheme _buildTextTheme(Color primary, Color muted) {
    return TextTheme(
      displayLarge:   GoogleFonts.tajawal(fontSize: 32, fontWeight: FontWeight.w900, color: primary),
      displayMedium:  GoogleFonts.tajawal(fontSize: 26, fontWeight: FontWeight.w800, color: primary),
      displaySmall:   GoogleFonts.tajawal(fontSize: 22, fontWeight: FontWeight.w700, color: primary),
      headlineLarge:  GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.w800, color: primary),
      headlineMedium: GoogleFonts.tajawal(fontSize: 18, fontWeight: FontWeight.w700, color: primary),
      headlineSmall:  GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
      titleLarge:     GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w700, color: primary),
      titleMedium:    GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w600, color: primary),
      titleSmall:     GoogleFonts.tajawal(fontSize: 12, fontWeight: FontWeight.w500, color: muted),
      bodyLarge:      GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w400, color: primary),
      bodyMedium:     GoogleFonts.tajawal(fontSize: 12, fontWeight: FontWeight.w400, color: primary),
      bodySmall:      GoogleFonts.tajawal(fontSize: 11, fontWeight: FontWeight.w400, color: muted),
      labelLarge:     GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w700, color: primary),
      labelMedium:    GoogleFonts.tajawal(fontSize: 11, fontWeight: FontWeight.w600, color: muted),
      labelSmall:     GoogleFonts.tajawal(fontSize: 10, fontWeight: FontWeight.w500, color: muted),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  ThemeData get theme => _isDark ? AppTheme.darkTheme() : AppTheme.lightTheme();
}