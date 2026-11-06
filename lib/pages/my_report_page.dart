import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/report_data.dart';
import '../providers/report_provider.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/app_header.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/report_card.dart';
import '../widgets/report_filter_tabs.dart';
import 'report_detail_page.dart';

class MyReportPage extends StatelessWidget {
  const MyReportPage({super.key, this.isAdmin = false});

  final bool isAdmin;

  void _openDetail(BuildContext context, ReportData report) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ReportDetailPage(report: report)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final provider = context.watch<ReportProvider>();
    final reports = provider.filteredReports;

    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              // Batasi lebar & tengahkan di layar lebar
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(r.pad, r.pad, r.pad, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isAdmin ? 'Kelola Laporan' : 'Laporan Saya',
                              style: AppTextStyles.bold(r.font(5.4)),
                            ),
                            SizedBox(height: r.gapS / 2),
                            Text(
                              isAdmin
                                  ? 'Kelola semua laporan yang telah dikirim mahasiswa.'
                                  : 'Pantau semua laporan yang telah Anda kirim.',
                              style: AppTextStyles.regular(
                                r.font(3.8),
                                color: AppColors.textGrey,
                              ),
                            ),
                            SizedBox(height: r.gap),
                            ReportFilterTabs(
                              selected: provider.filter,
                              onChanged: provider.setFilter,
                              countOf: provider.countOf,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: r.gap),
                      Expanded(
                        child: reports.isEmpty
                            ? _buildEmpty(r, provider.filter)
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(
                                  r.pad,
                                  r.gapS / 2,
                                  r.pad,
                                  r.bottom,
                                ),
                                itemCount: reports.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: r.gap),
                                itemBuilder: (context, index) {
                                  final report = reports[index];
                                  return ReportCard(
                                    report: report,
                                    showReporter: isAdmin,
                                    onTap: () => _openDetail(context, report),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(Responsive r, ReportFilter filter) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(r.pad),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: r.icon * 2,
              color: AppColors.muted,
            ),
            SizedBox(height: r.gap),
            Text(
              filter.emptyMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular(
                r.font(3.8),
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
