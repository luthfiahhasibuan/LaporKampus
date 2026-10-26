import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

/// Bottom navigation dengan ruang kosong di tengah untuk FAB.
/// State (tab aktif) disimpan di halaman, widget ini hanya menampilkan.
class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: Icons.home,
                  label: 'Beranda',
                  selected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
              ),
              const SizedBox(width: 70), // ruang untuk FAB
              Expanded(
                child: _NavItem(
                  icon: Icons.description,
                  label: 'Laporan',
                  selected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final color = selected ? AppColors.primary : AppColors.muted;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(icon, key: ValueKey(selected), size: 27, color: color),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style:
                (selected
                        ? AppTextStyles.bold(
                            r.font(3.3),
                            color: AppColors.primary,
                          )
                        : AppTextStyles.regular(
                            r.font(3.3),
                            color: AppColors.textGrey,
                          ))
                    .copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
