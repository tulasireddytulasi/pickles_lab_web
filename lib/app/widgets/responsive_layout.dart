import 'package:flutter/material.dart';
import 'package:pickles_lab_dashboard/app/core/theme/app_theme.dart';
import 'package:pickles_lab_dashboard/app/widgets/navigation/desktop_sidebar.dart';
import 'package:pickles_lab_dashboard/app/widgets/navigation/mobile_bottom_nav.dart';
import 'package:pickles_lab_dashboard/app/widgets/navigation/top_navigation_bar.dart';

/// A widget that uses LayoutBuilder to create a responsive scaffold structure.
///
/// It switches between a desktop layout (Sidebar + Main Content) and
/// a mobile layout (Top Bar + Main Content + Bottom Nav) based on the screen width.
class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop breakpoint is > 768px
        final isDesktop = constraints.maxWidth >= AppBreakpoints.desktop;

        if (isDesktop) {
          // --- Desktop Layout ---
          // Uses a Row: [Sidebar | Main Content (with Top Nav)]
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  // 1. Sidebar (Fixed width)
                  const DesktopSidebar(),

                  // 2. Main Content Area (Flexible width)
                  Expanded(
                    child: Column(
                      children: [
                        // 2a. Top Navigation Bar (Stretches across main content)
                        const TopNavigationBar(),

                        // 2b. Main Dashboard Content (The scrollable body)
                        Expanded(
                          child: SingleChildScrollView(padding: const EdgeInsets.all(24.0), child: child),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // --- Mobile/Tablet Layout ---
          // Uses a Scaffold with AppBar and BottomNavigationBar
          return Scaffold(
            // Top Nav acts as the AppBar
            appBar: AppBar(
              automaticallyImplyLeading: false, // Prevents back button on root
              toolbarHeight: 64, // Standard AppBar height for consistency
              titleSpacing: 0,
              title: const TopNavigationBar(isMobile: true),
            ),

            // Bottom Nav
            bottomNavigationBar: const MobileBottomNav(),

            // Main Dashboard Content
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: child,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
