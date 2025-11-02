// lib/widgets/data_display/status_badge.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

/// A reusable badge widget to display the status of an order.
///
/// It uses a color scheme defined in AppColors based on the status text.
/// This is a [StatelessWidget].
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine color based on the status string
    Color textColor;
    Color backgroundColor;

    switch (status.toLowerCase()) {
      case 'completed':
        textColor = AppColors.statusCompletedText;
        backgroundColor = AppColors.statusCompletedBg;
        break;
      case 'processing':
        textColor = AppColors.statusProcessingText;
        backgroundColor = AppColors.statusProcessingBg;
        break;
      case 'cancelled':
        textColor = AppColors.statusCancelledText;
        backgroundColor = AppColors.statusCancelledBg;
        break;
      default:
        textColor = AppColors.textMedium;
        backgroundColor = AppColors.border;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}