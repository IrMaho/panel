import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:toln/toln.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/view/widgets/stat_card.dart';
import 'package:app/features/accounting/bloc/accounting_cubit.dart';
import 'package:app/features/accounting/view/widgets/invoice_card.dart';

class AccountingContentView extends StatelessWidget {
  const AccountingContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingCubit, AccountingState>(
      builder: (context, state) {
        if (state.status == AccountingStatus.loading) {
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
                        'Accounting Management'.toLn(),
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ).animate().fadeIn().slideX(begin: -0.2),
                      const SizedBox(height: 8),
                      Text(
                        'Track invoices and financial transactions'.toLn(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ).animate(delay: 100.ms).fadeIn(),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: Text('Create Invoice'.toLn()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ).animate(delay: 200.ms).fadeIn().scale(),
                ],
              ),
              const SizedBox(height: 32),

              // Financial Summary Cards
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: [
                  StatCard(
                    title: 'Total Revenue'.toLn(),
                    value: '\$523,450',
                    icon: Icons.account_balance,
                    gradient: AppColors.cardGradient1,
                    changePercent: '+18.2%',
                    isPositive: true,
                  ).animate(delay: 250.ms).fadeIn().scale(),
                  StatCard(
                    title: 'Paid Invoices'.toLn(),
                    value: '\$412,300',
                    icon: Icons.check_circle,
                    gradient: AppColors.successGradient,
                    changePercent: '+12.5%',
                    isPositive: true,
                  ).animate(delay: 300.ms).fadeIn().scale(),
                  StatCard(
                    title: 'Pending'.toLn(),
                    value: '\$98,150',
                    icon: Icons.pending_actions,
                    gradient: AppColors.warningGradient,
                    changePercent: '+5.1%',
                    isPositive: false,
                  ).animate(delay: 350.ms).fadeIn().scale(),
                  StatCard(
                    title: 'Overdue'.toLn(),
                    value: '\$13,000',
                    icon: Icons.warning,
                    gradient: AppColors.errorGradient,
                    changePercent: '-3.2%',
                    isPositive: true,
                  ).animate(delay: 400.ms).fadeIn().scale(),
                ],
              ),
              const SizedBox(height: 32),

              // Filters
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search invoices...'.toLn(),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _FilterChip(label: 'All'.toLn(), isSelected: true),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Paid'.toLn(), isSelected: false),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Pending'.toLn(), isSelected: false),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Overdue'.toLn(), isSelected: false),
                ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.2),
              ),
              const SizedBox(height: 24),

              // Invoice List Header
              Text(
                'Recent Invoices'.toLn(),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ).animate(delay: 450.ms).fadeIn(),
              const SizedBox(height: 16),

              // Invoice Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.6,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final invoices = [
                    {
                      'number': 'INV-001',
                      'client': 'Acme Corporation'.toLn(),
                      'amount': '\$45,000',
                      'dueDate': '2025-12-15',
                      'status': 'paid',
                    },
                    {
                      'number': 'INV-002',
                      'client': 'Tech Solutions Inc.'.toLn(),
                      'amount': '\$32,500',
                      'dueDate': '2025-12-20',
                      'status': 'pending',
                    },
                    {
                      'number': 'INV-003',
                      'client': 'Global Enterprises'.toLn(),
                      'amount': '\$18,750',
                      'dueDate': '2025-11-30',
                      'status': 'overdue',
                    },
                    {
                      'number': 'INV-004',
                      'client': 'Innovation Labs'.toLn(),
                      'amount': '\$67,200',
                      'dueDate': '2025-12-25',
                      'status': 'paid',
                    },
                    {
                      'number': 'INV-005',
                      'client': 'Digital Agency'.toLn(),
                      'amount': '\$29,900',
                      'dueDate': '2025-12-18',
                      'status': 'pending',
                    },
                    {
                      'number': 'INV-006',
                      'client': 'StartUp Ventures'.toLn(),
                      'amount': '\$15,400',
                      'dueDate': '2025-11-28',
                      'status': 'overdue',
                    },
                  ];

                  final invoice = invoices[index];
                  return InvoiceCard(
                        invoiceNumber: invoice['number']!,
                        clientName: invoice['client']!,
                        amount: invoice['amount']!,
                        dueDate: invoice['dueDate']!,
                        status: _parseStatus(invoice['status']!),
                      )
                      .animate(delay: (500 + index * 50).ms)
                      .fadeIn()
                      .slideY(begin: 0.1);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  InvoiceStatus _parseStatus(String status) {
    switch (status) {
      case 'paid':
        return InvoiceStatus.paid;
      case 'pending':
        return InvoiceStatus.pending;
      case 'overdue':
        return InvoiceStatus.overdue;
      default:
        return InvoiceStatus.pending;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.divider,
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
