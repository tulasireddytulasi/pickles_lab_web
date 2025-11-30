// lib/widgets/payment_badge.dart

import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';
import 'package:pickles_lab_dashboard/app/core/utils/app_enums.dart';

/// A reusable widget to display the Payment Status with appropriate color styling.
class PaymentBadge extends StatelessWidget {
  final PaymentType status;

  const PaymentBadge({super.key, required this.status});

  String get _statusText => status.name[0].toUpperCase() + status.name.substring(1);

  Color get _textColor => status == PaymentType.paid ? AppColors.success : AppColors.secondary;
  Color get _backgroundColor => status == PaymentType.paid ? const Color(0xFFD1FAE5) : const Color(0xFFFFFBEB);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(9999.0), // rounded-full
      ),
      child: Text(
        _statusText,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: _textColor,
          fontWeight: FontWeight.w600, // font-semibold
          fontSize: 12,
        ),
      ),
    );
  }
}