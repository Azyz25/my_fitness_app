// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ─── Neon Green (softened – easier on eyes) ───────────────────────────────
  // Was #39FF14 (blinding). Now a balanced lime-neon that still reads as
  // "glowing" without causing strain.
  static const neonGreen    = Color(0xFF8FFF00); // softer lime-neon
  static const neonGreenDim = Color(0x228FFF00);
  static const neonGreenMid = Color(0x558FFF00);

  // ─── Dark Theme ───────────────────────────────────────────────────────────
  static const darkBg           = Color(0xFF0A0A0A);
  static const darkCard         = Color(0xFF141414);
  static const darkCard2        = Color(0xFF1C1C1C);
  static const darkBorder       = Color(0xFF2A2A2A);
  static const darkText         = Color(0xFFEEEEEE);
  static const darkTextMuted    = Color(0xFF888888);
  static const darkTextSecondary= Color(0xFF555555);

  // ─── Light Theme ──────────────────────────────────────────────────────────
  static const lightBg           = Color(0xFFFFFFFF);
  static const lightCard         = Color(0xFFF5F5F5);
  static const lightCard2        = Color(0xFFEBEBEB);
  static const lightBorder       = Color(0xFFDDDDDD);
  static const lightText         = Color(0xFF111111);
  static const lightTextMuted    = Color(0xFF666666);
  static const lightTextSecondary= Color(0xFF999999);

  // ─── Semantic ─────────────────────────────────────────────────────────────
  static const red    = Color(0xFFFF453A);
  static const orange = Color(0xFFFF9F0A);
  static const blue   = Color(0xFF0A84FF);
  static const purple = Color(0xFFBF5AF2);
}

class AppTheme {
  // ─── Glow helpers (reduced spread & opacity) ─────────────────────────────
  static BoxShadow neonGlow({
    double spread = 0,
    double blur = 10,
    double opacity = 0.35,
  }) {
    return BoxShadow(
      color: AppColors.neonGreen.withOpacity(opacity),
      blurRadius: blur,
      spreadRadius: spread,
    );
  }

  static List<BoxShadow> neonGlowList({
    double blur = 10,
    double opacity = 0.30,
  }) =>
      [
        BoxShadow(
          color: AppColors.neonGreen.withOpacity(opacity),
          blurRadius: blur,
        ),
        BoxShadow(
          color: AppColors.neonGreen.withOpacity(opacity * 0.35),
          blurRadius: blur * 2.2,
        ),
      ];

  // ─── Dark Theme ───────────────────────────────────────────────────────────
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
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
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.darkText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBg,
        selectedItemColor: AppColors.neonGreen,
        unselectedItemColor: AppColors.darkTextMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      dividerColor: AppColors.darkBorder,
      useMaterial3: true,
    );
  }

  // ─── Light Theme ──────────────────────────────────────────────────────────
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
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
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.lightText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBg,
        selectedItemColor: AppColors.neonGreen,
        unselectedItemColor: AppColors.lightTextMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      dividerColor: AppColors.lightBorder,
      useMaterial3: true,
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
