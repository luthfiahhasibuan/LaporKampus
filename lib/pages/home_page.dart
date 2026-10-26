import 'package:flutter/material.dart';

import '../widgets/app_header.dart';
import '../widgets/menu_card.dart';
import '../widgets/statistics_section.dart';
import '../widgets/welcome_card.dart';
import '../utils/app_theme.dart';
import '../widgets/recent_reports_card.dart';
import '../providers/report_provider.dart';
import '../utils/responsive.dart';

import 'package:provider/provider.dart';

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
            child: OrientationBuilder(
              builder: (context, orientation) {
                return orientation == Orientation.landscape
                    ? _buildLandscape(context)
                    : _buildPortrait(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return const WelcomeCard(
      name: 'Luthfi',
      universityName: 'Konoha University',
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    final r = context.r;
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

  Widget _buildPortrait(BuildContext context) {
    final r = context.r;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(r.pad, r.pad, r.pad, r.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcome(),
          SizedBox(height: r.gap),
          ..._buildContent(context),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    final r = context.r;
    return Padding(
      padding: EdgeInsets.fromLTRB(r.pad, r.pad, r.pad, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kiri: tidak ikut scroll kanan. Scroll sendiri hanya jika
          // layar terlalu pendek supaya tidak overflow.
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: _buildWelcome(),
            ),
          ),
          SizedBox(width: r.gap),
          // Kanan: scrollable
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: r.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
