import 'package:flutter/material.dart';

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
      child: Row(
        children: [
          Expanded(
            child: StatisticCard(
              icon: Icons.folder,
              color: Colors.blue,
              number: '$total',
              label: 'Total',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatisticCard(
              icon: Icons.send,
              color: Colors.orange,
              number: '$sent',
              label: 'Terkirim',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StatisticCard(
              icon: Icons.check_circle,
              color: Colors.green,
              number: '$responded',
              label: 'Ditanggapi',
            ),
          ),
        ],
      ),
    );
  }
}
