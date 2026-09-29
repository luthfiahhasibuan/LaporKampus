import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'statistic_card.dart';

/// Baris berisi tiga StatisticCard. Angka dikirim dari luar
/// supaya nanti mudah diganti dengan data asli.
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: StatisticCard(
              icon: Icons.folder,
              number: '$total',
              label: 'Total',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatisticCard(
              icon: Icons.send,
              number: '$sent',
              label: 'Terkirim',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatisticCard(
              icon: Icons.check_circle,
              number: '$responded',
              label: 'Ditanggapi',
            ),
          ),
        ],
      ),
    );
  }
}
