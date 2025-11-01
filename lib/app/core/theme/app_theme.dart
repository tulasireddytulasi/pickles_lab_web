// lib/config/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Defines screen size breakpoints based on HTML/CSS media queries.
class AppBreakpoints {
  static const double desktop = 769.0;
  static const double tablet = 600.0;
  static const double mobile = 0.0;
}

/// Centralized application theme and styling.
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,

    // Define the primary font (Inter)
    fontFamily: GoogleFonts.inter().fontFamily,

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.cardBackground,
    ),

    // Card and Shadow Styles
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // rounded-button (8px)
        side: const BorderSide(color: AppColors.border, width: 0),
      ),
      shadowColor: Colors.black.withValues(alpha: 0.05), // Mimic shadow-sm
    ),

    // Text Theme (Inter font)
    textTheme: TextTheme(
      // Dashboard Header: "Dashboard Overview" (text-2xl font-semibold)
      headlineLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark
      ),
      // Metric Card value: "$12,628" (text-2xl font-semibold)
      headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark
      ),
      // Card titles: "Sales Trend", "Recent Orders" (font-medium)
      titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark
      ),
      // Card subtitles / item names (font-medium)
      titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark
      ),
      // Body text and smaller details
      bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark
      ),
      bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textMedium
      ),
    ),

    // Input Decoration Theme (Search Bar, Select Field)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background, // bg-gray-50
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), // rounded-button
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.primary), // focus:border-primary
      ),
      hintStyle: GoogleFonts.inter(color: AppColors.textLight, fontSize: 14),
    ),
  );
}