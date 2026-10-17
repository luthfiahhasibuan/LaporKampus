import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/menu_card.dart';
import '../widgets/statistics_section.dart';
import '../widgets/welcome_card.dart';
import '../constants/app_colors.dart';
import '../widgets/recent_reports_card.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onNewReport;
  final VoidCallback onOpenMyReports;

  const HomePage({
    super.key,
    required this.onNewReport,
    required this.onOpenMyReports,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeCard(
                    name: 'Luthfi',
                    universityName: 'Konoha University',
                  ),
                  const SizedBox(height: 25),
                  const StatisticsSection(total: 5, sent: 0, responded: 0),

                  const SizedBox(height: 30),
                  MenuCard(
                    icon: Icons.edit_square,
                    title: 'Tulis Laporan Baru',
                    subtitle: 'Sampaikan keluhan dan aspirasi anda',
                    gradient: AppColors.secondaryGradient,
                    onTap: onNewReport,
                  ),
                  const SizedBox(height: 20),
                  MenuCard(
                    icon: Icons.format_list_bulleted,
                    title: 'Lihat Laporan Saya',
                    subtitle: 'Pantau status semua laporan anda',
                    gradient: AppColors.primaryGradient,
                    onTap: onOpenMyReports,
                  ),

                  const SizedBox(height: 30),
                  const RecentReportsCard(reports: []),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
