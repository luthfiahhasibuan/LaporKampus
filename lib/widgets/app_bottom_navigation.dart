import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class AppNavItem {
  final IconData icon;
  final String label;

  const AppNavItem({required this.icon, required this.label});
}

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavItem> items;

  // menyisakan ruang tenganh untuk FAB
  final bool reserveFabSpace;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = studentItems,
    this.reserveFabSpace = true,
  });

  static const List<AppNavItem> studentItems = [
    AppNavItem(icon: Icons.home, label: 'Beranda'),
    AppNavItem(icon: Icons.description, label: 'Laporan'),
  ];

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: r.sp(16.5),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (reserveFabSpace && i == items.length ~/ 2)
                  SizedBox(width: r.sp(18)), // ruang untuk FAB
                Expanded(
                  child: _NavItem(
                    item: items[i],
                    selected: currentIndex == i,
                    onTap: () => onTap(i),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final AppNavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final color = selected ? AppColors.primary : AppColors.muted;
    final style = selected ? AppTextStyles.bold : AppTextStyles.regular;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              item.icon,
              key: ValueKey(selected),
              size: r.sp(7),
              color: color,
            ),
          ),
          SizedBox(height: r.gapS / 4),
          Text(item.label, style: style(r.font(3.3), color: color)),
        ],
      ),
    );
  }
}
