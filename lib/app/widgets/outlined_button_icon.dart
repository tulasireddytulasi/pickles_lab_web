import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

class OutlinedButtonIcon extends StatelessWidget {
  const OutlinedButtonIcon({
    super.key,
    required this.onExportTapped,
    required this.label,
    required this.semanticsLabel,
  });

  final VoidCallback onExportTapped;
  final String label;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: OutlinedButton.icon(
        onPressed: onExportTapped,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textDark,
          backgroundColor: AppColors.cardBackground,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        icon: const Icon(Icons.arrow_downward_outlined, size: 18),
        label: Text(label, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
      ),
    );
  }
}
