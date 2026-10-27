import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/menu_card.dart';
import '../widgets/statistics_section.dart';
import '../widgets/welcome_card.dart';
import '../utils/app_theme.dart';
import '../widgets/recent_reports_card.dart';
import '../providers/report_provider.dart';
import '../utils/responsive.dart';
import '../data/dummy_data.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onNewReport;
  final VoidCallback onOpenMyReports;

  const HomePage({
    super.key,
    required this.onNewReport,
    required this.onOpenMyReports,
  });

  Widget _buildWelcome() {
    return WelcomeCard(
      name: currentUser?.name ?? 'Pengguna',
      universityName: 'Konoha University',
    );
  }

  List<Widget> _buildContent(Responsive r) {
    return [
      Consumer<ReportProvider>(
        builder: (context, provider, _) => StatisticsSection(
          total: provider.total,
          sent: provider.sent,
          responded: provider.responded,
        ),
      ),

      SizedBox(height: r.gap),
      MenuCard(
        icon: Icons.edit_square,
        title: 'Tulis Laporan Baru',
        subtitle: 'Sampaikan keluhan dan aspirasi anda',
        gradient: AppColors.primaryGradient,
        onTap: onNewReport,
      ),
      SizedBox(height: r.gap),
      MenuCard(
        icon: Icons.format_list_bulleted,
        title: 'Lihat Laporan Saya',
        subtitle: 'Pantau status semua laporan anda',
        gradient: AppColors.secondaryGradient,
        onTap: onOpenMyReports,
      ),
      SizedBox(height: r.gap),
      const RecentReportsCard(reports: []),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final isLandscape = r.isLandscape;

    final scrollable = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(r.pad, r.pad, r.pad, r.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isLandscape) ...[_buildWelcome(), SizedBox(height: r.gap)],
          ..._buildContent(r),
        ],
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: isLandscape
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(
                            r.pad,
                            r.pad,
                            0,
                            r.bottom,
                          ),
                          child: _buildWelcome(),
                        ),
                      ),
                      Expanded(flex: 6, child: scrollable),
                    ],
                  )
                : scrollable,
          ),
        ],
      ),
    );
  }
}
