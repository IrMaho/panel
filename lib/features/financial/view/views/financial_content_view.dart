import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:toln/toln.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/view/widgets/stat_card.dart';
import 'package:app/core/view/widgets/responsive_grid.dart';
import 'package:app/features/financial/bloc/financial_cubit.dart';
import 'package:app/features/financial/view/widgets/transaction_card.dart';

class FinancialContentView extends StatelessWidget {
  const FinancialContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialCubit, FinancialState>(
      builder: (context, state) {
        if (state.status == FinancialStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Financial Overview'.toLn(),
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ).animate().fadeIn().slideX(begin: -0.2),
                      const SizedBox(height: 8),
                      Text(
                        'Track your income, expenses, and financial health'
                            .toLn(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ).animate(delay: 100.ms).fadeIn(),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list),
                        label: Text('Filter'.toLn()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                          side: BorderSide(color: AppColors.divider),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: Text('Add Transaction'.toLn()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ].animate(interval: 50.ms).fadeIn().scale(),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Summary Cards with ResponsiveGrid
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                spacing: 24,
                aspectRatio: 1.5,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final stats = [
                    {
                      'title': 'Total Balance'.toLn(),
                      'value': '\$87,430',
                      'icon': Icons.account_balance_wallet,
                      'gradient': AppColors.cardGradient1,
                      'change': '+15.2%',
                      'positive': true,
                    },
                    {
                      'title': 'Total Income'.toLn(),
                      'value': '\$124,650',
                      'icon': Icons.trending_up,
                      'gradient': AppColors.successGradient,
                      'change': '+22.5%',
                      'positive': true,
                    },
                    {
                      'title': 'Total Expenses'.toLn(),
                      'value': '\$37,220',
                      'icon': Icons.trending_down,
                      'gradient': AppColors.errorGradient,
                      'change': '+8.1%',
                      'positive': false,
                    },
                    {
                      'title': 'Savings Rate'.toLn(),
                      'value': '70%',
                      'icon': Icons.savings,
                      'gradient': AppColors.cardGradient4,
                      'change': '+5.3%',
                      'positive': true,
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
              const SizedBox(height: 32),

              // Monthly Trend Chart
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Trend'.toLn(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Income vs Expenses Over Time'.toLn(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Icon(
                          Icons.show_chart,
                          color: Colors.white.withOpacity(0.3),
                          size: 80,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ChartLegend(
                            color: AppColors.success,
                            label: 'Income'.toLn(),
                          ),
                          _ChartLegend(
                            color: AppColors.error,
                            label: 'Expenses'.toLn(),
                          ),
                          _ChartLegend(
                            color: AppColors.warning,
                            label: 'Savings'.toLn(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate(delay: 450.ms).fadeIn().slideY(begin: 0.2),
              const SizedBox(height: 32),

              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions'.toLn(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate(delay: 500.ms).fadeIn(),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                    label: Text('View All'.toLn()),
                  ).animate(delay: 500.ms).fadeIn(),
                ],
              ),
              const SizedBox(height: 16),

              // Transaction List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final transactions = [
                    {
                      'title': 'Monthly Salary'.toLn(),
                      'category': 'Salary'.toLn(),
                      'amount': '+\$8,500',
                      'date': '2025-11-20',
                      'type': 'income',
                    },
                    {
                      'title': 'Website Design Project'.toLn(),
                      'category': 'Freelance'.toLn(),
                      'amount': '+\$2,400',
                      'date': '2025-11-18',
                      'type': 'income',
                    },
                    {
                      'title': 'Grocery Shopping'.toLn(),
                      'category': 'Groceries'.toLn(),
                      'amount': '-\$285',
                      'date': '2025-11-19',
                      'type': 'expense',
                    },
                    {
                      'title': 'Electricity Bill'.toLn(),
                      'category': 'Utilities'.toLn(),
                      'amount': '-\$120',
                      'date': '2025-11-17',
                      'type': 'expense',
                    },
                    {
                      'title': 'Cinema Tickets'.toLn(),
                      'category': 'Entertainment'.toLn(),
                      'amount': '-\$45',
                      'date': '2025-11-16',
                      'type': 'expense',
                    },
                  ];

                  final transaction = transactions[index];
                  return TransactionCard(
                        title: transaction['title']!,
                        category: transaction['category']!,
                        amount: transaction['amount']!,
                        date: transaction['date']!,
                        type: transaction['type'] == 'income'
                            ? TransactionType.income
                            : TransactionType.expense,
                        icon: _getCategoryIcon(transaction['category']!),
                      )
                      .animate(delay: (550 + index * 50).ms)
                      .fadeIn()
                      .slideX(begin: 0.1);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    if (category.contains('Salary')) return Icons.work;
    if (category.contains('Freelance')) return Icons.laptop_mac;
    if (category.contains('Groceries')) return Icons.shopping_cart;
    if (category.contains('Utilities')) return Icons.bolt;
    if (category.contains('Entertainment')) return Icons.movie;
    return Icons.attach_money;
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
