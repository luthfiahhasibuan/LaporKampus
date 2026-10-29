import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class StatisticsSection extends StatelessWidget {
  final int total;
  final int sent;
  final int responded;

  const StatisticsSection({
    super.key,
    required this.total,
    required this.sent,
    required this.responded,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_StatItem>[
      _StatItem(icon: Icons.folder_rounded, number: '$total', label: 'Total'),
      _StatItem(icon: Icons.send_rounded, number: '$sent', label: 'Terkirim'),
      _StatItem(
        icon: Icons.check_circle_rounded,
        number: '$responded',
        label: 'Ditanggapi',
      ),
    ];

    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: _StatisticCard(item: items[i])),
        ],
      ],
    );
  }
}

class _StatItem {
  final IconData icon;
  final String number;
  final String label;

  const _StatItem({
    required this.icon,
    required this.number,
    required this.label,
  });
}

class _StatisticCard extends StatelessWidget {
  final _StatItem item;

  const _StatisticCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            item.number,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryDark,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
