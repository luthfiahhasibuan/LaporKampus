import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

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
    final r = context.r;
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
          if (i > 0) SizedBox(width: r.gap),
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
    final r = context.r;

    return Container(
      height: r.sp(33),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(r.radius),
        border: Border.all(color: AppColors.primary, width: r.stroke),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: r.gap,
            offset: Offset(0, r.gapS / 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(r.gapS),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: AppColors.primary, size: r.icon),
          ),
          SizedBox(height: r.gapS),
          Text(
            item.number,
            style: AppTextStyles.bold(
              r.font(5.6),
              color: AppColors.primaryDark,
              height: 1.1,
            ),
          ),
          Text(
            item.label,
            style: AppTextStyles.medium(r.font(3.1), color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
