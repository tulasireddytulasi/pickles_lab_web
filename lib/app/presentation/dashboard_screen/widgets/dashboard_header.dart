import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_colors.dart';

/// The header section of the dashboard containing the title, date range selector,
/// and the export button.
///
/// This is a [StatefulWidget] to manage the state of the dropdown selection.
class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String _dateRange = 'Last 7 Days';
  final List<String> _dateRangeOptions = [
    'Today',
    'Yesterday',
    'Last 7 Days',
    'Last 30 Days',
    'Custom Range'
  ];

  @override
  Widget build(BuildContext context) {
    // Check screen width for responsiveness
    final isMobile = MediaQuery.of(context).size.width < 769;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title: "Dashboard Overview"
        Text(
          'Dashboard Overview',
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        const SizedBox(height: 4.0),

        // Subtitle/Welcome
        Text(
          'Welcome back, Admin. Here is an overview of your Pickles sales.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.textMedium,
          ),
        ),

        const SizedBox(height: 24.0),

        // Action Row (Dropdown + Export Button)
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Range Selector (Dropdown)
            _buildDateRangeSelector(context, isMobile),

            // Vertical spacing for mobile
            if (isMobile) const SizedBox(height: 16.0),

            // Export Button
            _buildExportButton(context),
          ],
        ),
      ],
    );
  }

  /// Builds the custom-styled dropdown for the date range.
  Widget _buildDateRangeSelector(BuildContext context, bool isMobile) {
    return Container(
      // Ensure it doesn't take full width on desktop
      width: isMobile ? double.infinity : 180,
      child: Semantics(
        label: 'Select date range',
        child: DropdownButtonFormField<String>(
          value: _dateRange,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _dateRange = newValue;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Date range set to: $_dateRange')),
              );
            }
          },
          items: _dateRangeOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            hintText: 'Select Range',
            fillColor: AppColors.cardBackground, // Override Input Theme to match HTML (bg-white)
            filled: true,
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMedium),
        ),
      ),
    );
  }

  /// Builds the primary "Export" button.
  Widget _buildExportButton(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Export data to CSV',
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Exporting data...')),
          );
        },
        icon: const Icon(Icons.file_download_outlined, size: 20, color: AppColors.cardBackground),
        label: Text(
          'Export',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.cardBackground,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}