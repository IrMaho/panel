import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:toln/toln.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/warehouse/bloc/warehouse_cubit.dart';
import 'package:app/features/warehouse/view/widgets/inventory_card.dart';

class WarehouseContentView extends StatelessWidget {
  const WarehouseContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarehouseCubit, WarehouseState>(
      builder: (context, state) {
        if (state.status == WarehouseStatus.loading) {
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
                        'Warehouse Management'.toLn(),
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ).animate().fadeIn().slideX(begin: -0.2),
                      const SizedBox(height: 8),
                      Text(
                        'Manage your inventory and stock levels'.toLn(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ).animate(delay: 100.ms).fadeIn(),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: Text('Add Item'.toLn()),
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

              // Stats Summary
              Row(
                children: [
                  Expanded(
                    child: _StatBox(
                      label: 'Total Items'.toLn(),
                      value: '3,456',
                      icon: Icons.inventory_2,
                      color: AppColors.cardGradient3,
                    ).animate(delay: 250.ms).fadeIn().slideY(begin: 0.2),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatBox(
                      label: 'Low Stock'.toLn(),
                      value: '47',
                      icon: Icons.warning_amber,
                      color: AppColors.warningGradient,
                    ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatBox(
                      label: 'Out of Stock'.toLn(),
                      value: '12',
                      icon: Icons.error,
                      color: AppColors.errorGradient,
                    ).animate(delay: 350.ms).fadeIn().slideY(begin: 0.2),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Search and Filter
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search inventory...'.toLn(),
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
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {},
                    ),
                  ),
                ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.2),
              ),
              const SizedBox(height: 24),

              // Inventory Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final inventory = [
                    {
                      'name': 'Wireless Mouse'.toLn(),
                      'code': 'ELEC-001',
                      'current': '145',
                      'max': '200',
                      'category': 'Electronics'.toLn(),
                    },
                    {
                      'name': 'Office Chair'.toLn(),
                      'code': 'FURN-023',
                      'current': '23',
                      'max': '50',
                      'category': 'Furniture'.toLn(),
                    },
                    {
                      'name': 'T-Shirt (L)'.toLn(),
                      'code': 'CLTH-089',
                      'current': '8',
                      'max': '100',
                      'category': 'Clothing'.toLn(),
                    },
                    {
                      'name': 'Laptop Stand'.toLn(),
                      'code': 'ELEC-045',
                      'current': '67',
                      'max': '80',
                      'category': 'Electronics'.toLn(),
                    },
                    {
                      'name': 'Desk Lamp'.toLn(),
                      'code': 'ELEC-112',
                      'current': '189',
                      'max': '200',
                      'category': 'Electronics'.toLn(),
                    },
                    {
                      'name': 'Storage Box'.toLn(),
                      'code': 'FURN-067',
                      'current': '42',
                      'max': '60',
                      'category': 'Furniture'.toLn(),
                    },
                  ];

                  final item = inventory[index];
                  return InventoryCard(
                    itemName: item['name']!,
                    itemCode: item['code']!,
                    currentStock: int.parse(item['current']!),
                    maxStock: int.parse(item['max']!),
                    category: item['category']!,
                    icon: _getCategoryIcon(item['category']!),
                  ).animate(delay: (400 + index * 50).ms).fadeIn().scale();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    // Remove .toLn() for icon matching
    final baseCategory = category.split('.toLn()').first;
    switch (baseCategory) {
      case 'Electronics':
        return Icons.devices;
      case 'Furniture':
        return Icons.weekend;
      case 'Clothing':
        return Icons.checkroom;
      default:
        return Icons.inventory_2;
    }
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Gradient color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.colors.first.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
