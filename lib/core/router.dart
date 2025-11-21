import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/view/app_shell.dart';
import 'package:app/features/dashboard/view/dashboard_page.dart';
import 'package:app/features/financial/view/financial_page.dart';
import 'package:app/features/warehouse/view/warehouse_page.dart';
import 'package:app/features/accounting/view/accounting_page.dart';
import 'package:app/features/settings/view/settings_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppShell(currentPath: state.matchedLocation, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: DashboardPage()),
        ),
        GoRoute(
          path: '/financial',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: FinancialPage()),
        ),
        GoRoute(
          path: '/warehouse',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: WarehousePage()),
        ),
        GoRoute(
          path: '/accounting',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: AccountingPage()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) =>
              NoTransitionPage(key: state.pageKey, child: SettingsPage()),
        ),
      ],
    ),
  ],
);
