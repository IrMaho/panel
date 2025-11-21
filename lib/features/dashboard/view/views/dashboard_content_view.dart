import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:toln/toln.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/view/widgets/stat_card.dart';
import 'package:app/core/view/widgets/responsive_layout.dart';
import 'package:app/core/view/widgets/responsive_grid.dart';
import 'package:app/features/dashboard/bloc/dashboard_cubit.dart';

class DashboardContentView extends StatelessWidget {
  const DashboardContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.status == DashboardStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final padding = ResponsiveLayout.getResponsivePadding(context);
        final spacing = ResponsiveLayout.getResponsiveSpacing(context);

        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),
              SizedBox(height: spacing * 1.5),

              // Stats Cards Grid
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                spacing: spacing,
                aspectRatio: 1.5,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final stats = [
                    {
                      'title': 'Total Revenue'.toLn(),
                      'value': '\$523,450',
                      'icon': Icons.attach_money,
                      'gradient': AppColors.cardGradient1,
                      'change': '+18.2%',
                      'positive': true,
                    },
                    {
                      'title': 'Orders'.toLn(),
                      'value': '1,245',
                      'icon': Icons.shopping_cart,
                      'gradient': AppColors.cardGradient2,
                      'change': '+12.5%',
                      'positive': true,
                    },
                    {
                      'title': 'Inventory Items'.toLn(),
                      'value': '3,892',
                      'icon': Icons.inventory,
                      'gradient': AppColors.cardGradient3,
                      'change': '+5.1%',
                      'positive': true,
                    },
                    {
                      'title': 'Pending Invoices'.toLn(),
                      'value': '23',
                      'icon': Icons.receipt,
                      'gradient': AppColors.cardGradient4,
                      'change': '-3.2%',
                      'positive': false,
                    },
                  ];

                  final stat = stats[index];
                  return StatCard(
                    title: stat['title'] as String,
                    value: stat['value'] as String,
                    icon: stat['icon'] as IconData,
                    gradient: stat['gradient'] as Gradient,
                    changePercent: stat['change'] as String,
                    isPositive: stat['positive'] as bool,
                  ).animate(delay: (250 + index * 50).ms).fadeIn().scale();
                },
              ),
              SizedBox(height: spacing * 1.5),

              // Quick Actions
              Text(
                'Quick Actions'.toLn(),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ).animate(delay: 450.ms).fadeIn(),
              SizedBox(height: spacing),

              ResponsiveGrid(
                mobileColumns: 2,
                tabletColumns: 2,
                desktopColumns: 4,
                spacing: spacing,
                aspectRatio: ResponsiveLayout.isMobile(context) ? 1.2 : 1.5,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final actions = [
                    {
                      'label': 'New Order'.toLn(),
                      'icon': Icons.add_shopping_cart,
                      'color': AppColors.primary,
                    },
                    {
                      'label': 'Add Inventory'.toLn(),
                      'icon': Icons.add_box,
                      'color': AppColors.success,
                    },
                    {
                      'label': 'Create Invoice'.toLn(),
                      'icon': Icons.receipt_long,
                      'color': AppColors.warning,
                    },
                    {
                      'label': 'View Reports'.toLn(),
                      'icon': Icons.analytics,
                      'color': AppColors.accent,
                    },
                  ];

                  final action = actions[index];
                  return _QuickActionCard(
                    label: action['label'] as String,
                    icon: action['icon'] as IconData,
                    color: action['color'] as Color,
                  ).animate(delay: (500 + index * 50).ms).fadeIn().scale();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview'.toLn(),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ).animate().fadeIn().slideX(begin: -0.2),
          const SizedBox(height: 8),
          Text(
            'Welcome back! Here\'s your business summary'.toLn(),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ).animate(delay: 100.ms).fadeIn(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  DateTime.now().toString().split(' ')[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ).animate(delay: 200.ms).fadeIn().scale(),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview'.toLn(),
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ).animate().fadeIn().slideX(begin: -0.2),
            const SizedBox(height: 8),
            Text(
              'Welcome back! Here\'s your business summary'.toLn(),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ).animate(delay: 100.ms).fadeIn(),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ).animate(delay: 200.ms).fadeIn().scale(),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _QuickActionCard({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
