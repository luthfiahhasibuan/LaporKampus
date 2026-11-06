import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/report_provider.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/app_header.dart';
import '../widgets/report_card.dart';
import '../widgets/statistics_section.dart';
import 'report_detail_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key, required this.onOpenReports});

  final VoidCallback onOpenReports;

  static const int _previewCount = 3;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final provider = context.watch<ReportProvider>();
    final pending = provider.pendingReports;

    return SafeArea(
      child: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(r.pad, r.pad, r.pad, r.bottom),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard Admin',
                        style: AppTextStyles.bold(r.font(5.4)),
                      ),
                      SizedBox(height: r.gapS / 2),
                      Text(
                        'Ringkasan laporan dari seluruh mahasiswa.',
                        style: AppTextStyles.regular(
                          r.font(3.8),
                          color: AppColors.textGrey,
                        ),
                      ),
                      SizedBox(height: r.gap),
                      StatisticsSection(
                        total: provider.total,
                        sent: provider.countOf(ReportFilter.sent),
                        responded: provider.responded,
                      ),
                      SizedBox(height: r.pad),
                      _buildPendingHeader(r),
                      SizedBox(height: r.gap),
                      if (pending.isEmpty)
                        _buildEmpty(r)
                      else
                        for (final report in pending.take(_previewCount)) ...[
                          ReportCard(
                            report: report,
                            showReporter: true,
                            onTap: () => ReportDetailPage.open(
                              context,
                              report,
                              isAdmin: true,
                            ),
                          ),
                          SizedBox(height: r.gap),
                        ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingHeader(Responsive r) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Perlu Ditanggapi',
            style: AppTextStyles.bold(r.font(4.4)),
          ),
        ),
        TextButton(
          onPressed: onOpenReports,
          child: Text(
            'Lihat semua',
            style: AppTextStyles.semibold(
              r.font(3.6),
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty(Responsive r) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.pad),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(r.radius),
        border: Border.all(color: AppColors.muted, width: r.stroke),
      ),
      child: Column(
        children: [
          Icon(Icons.task_alt, size: r.icon * 2, color: AppColors.primary),
          SizedBox(height: r.gap),
          Text(
            'Semua laporan sudah ditanggapi.',
            textAlign: TextAlign.center,
            style: AppTextStyles.regular(
              r.font(3.8),
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
