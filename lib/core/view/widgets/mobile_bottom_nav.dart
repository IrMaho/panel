import 'package:flutter/material.dart';
import 'package:toln/toln.dart';

class MobileBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MobileBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard),
          label: 'Dashboard'.toLn(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_balance_wallet),
          label: 'Financial'.toLn(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.warehouse),
          label: 'Warehouse'.toLn(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.receipt_long),
          label: 'Accounting'.toLn(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Settings'.toLn(),
        ),
      ],
    );
  }
}
