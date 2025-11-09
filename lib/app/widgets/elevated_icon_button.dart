import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    super.key,
    required this.onExportTapped,
    required this.label,
    required this.width,
    required this.semanticsLabel,
    required this.icon,
    this.labelStyle,
    this.buttonStyle,
  });

  final VoidCallback onExportTapped;
  final String label;
  final String semanticsLabel;
  final double width;
  final Widget icon;
  final TextStyle? labelStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Semantics(
        button: true,
        label: semanticsLabel,
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting data...')));
          },
          icon: icon,
          label: Text(
            label,
            style:
                labelStyle ??
                Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.cardBackground, fontWeight: FontWeight.w600),
          ),
          style:
              buttonStyle ??
              ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
        ),
      ),
    );
  }
}
