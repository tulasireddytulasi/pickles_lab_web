// lib/config/theme/app_colors.dart

import 'package:flutter/material.dart';

/// Defines the centralized color palette for the Pickles Dashboard.
///
/// Colors are derived from the Tailwind configuration in the HTML:
/// primary: #4CAF50 (Green), secondary: #FFC107 (Amber/Yellow).
class AppColors {
  // Primary & Secondary
  static const Color primary = Color(0xFF4CAF50); // Primary (Green)
  static const Color primaryLight = Color(0xFF81C784);
  static const Color primaryBackground = Color(0x1A4CAF50); // Primary/10
  static const Color secondary = Color(0xFFFFC107); // Secondary (Yellow)
  static const Color secondaryBackground = Color(0x1AFFC107); // Secondary/10

  // Neutral Colors (Matching Tailwind/Inter)
  static const Color background = Color(0xFFF9FAFB); // body background-color
  static const Color cardBackground = Colors.white; // bg-white
  static const Color textDark = Color(0xFF1F2937); // Base text (gray-800)
  static const Color textMedium = Color(0xFF6B7280); // Gray-500
  static const Color textLight = Color(0xFF9CA3AF); // Gray-400
  static const Color border = Color(0xFFE5E7EB); // Gray-200
  static const Color success = Color(0xFF10B981); // Green-500
  static const Color danger = Color(0xFFEF4444); // Red-500
  static const Color info = Color(0xFF3B82F6); // Blue-500

  // Status Badge Colors (Derived from CSS)
  static const Color statusCompletedText = primary;
  static const Color statusCompletedBg = Color(0x1A4CAF50); // rgba(76, 175, 80, 0.1)
  static const Color statusProcessingText = secondary;
  static const Color statusProcessingBg = Color(0x1AFFC107); // rgba(255, 193, 7, 0.1)
  static const Color statusCancelledText = Color(0xFFF44336);
  static const Color statusCancelledBg = Color(0x1AF44336); // rgba(244, 67, 54, 0.1)
}