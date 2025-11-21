import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/view/widgets/sidebar_navigation.dart';
import 'package:app/core/view/widgets/responsive_layout.dart';
import 'package:app/core/view/widgets/mobile_bottom_nav.dart';
import 'package:app/features/financial/view/financial_page.dart';
import 'package:app/features/warehouse/view/warehouse_page.dart';
import 'package:app/features/accounting/view/accounting_page.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const AppShell({super.key, required this.child, required this.currentPath});

  int _getIndexFromPath(String path) {
    if (path == '/') return 0;
    if (path == FinancialPage.routePath) return 1;
    if (path == WarehousePage.routePath) return 2;
    if (path == AccountingPage.routePath) return 3;
    if (path == '/settings') return 4;
    return 0;
  }

  String _getPathFromIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return FinancialPage.routePath;
      case 2:
        return WarehousePage.routePath;
      case 3:
        return AccountingPage.routePath;
      case 4:
        return '/settings';
      default:
        return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        // Mobile: Content only (bottom nav handles navigation)
        mobile: child,

        // Tablet: Rail sidebar + content
        tablet: Row(
          children: [
            SidebarNavigation(currentPath: currentPath, isRailMode: true),
            Expanded(child: child),
          ],
        ),

        // Desktop: Full sidebar + content
        desktop: Row(
          children: [
            SidebarNavigation(currentPath: currentPath, isRailMode: false),
            Expanded(child: child),
          ],
        ),
      ),

      // Bottom navigation for mobile only
      bottomNavigationBar: ResponsiveLayout.isMobile(context)
          ? MobileBottomNav(
              currentIndex: _getIndexFromPath(currentPath),
              onTap: (index) {
                context.go(_getPathFromIndex(index));
              },
            )
          : null,

      // Drawer for mobile (optional - for additional menu items)
      drawer: ResponsiveLayout.isMobile(context)
          ? Drawer(
              child: SidebarNavigation(
                currentPath: currentPath,
                isDrawerMode: true,
              ),
            )
          : null,
    );
  }
}
