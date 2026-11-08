import 'package:flutter/material.dart';

import '../models/report_data.dart';
import '../utils/app_theme.dart';
import '../utils/date_format.dart';
import '../utils/responsive.dart';
import 'app_card.dart';
import 'gradient_card_header.dart';
import 'report_status_chip.dart';

class RecentReportsCard extends StatelessWidget {
  const RecentReportsCard({
    super.key,
    required this.reports,
    required this.onReportTap,
  });

  final List<ReportData> reports;
  final ValueChanged<ReportData> onReportTap;

  static const int _maxItems = 5;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final items = reports.take(_maxItems).toList();

    return AppCard(
      child: Column(
        children: [
          const GradientCardHeader(
            icon: Icons.history,
            title: 'Laporan Terbaru',
            subtitle: 'Ketuk laporan untuk melihat detail',
          ),
          if (items.isEmpty)
            _buildEmpty(r)
          else ...[
            _buildColumnTitles(r),
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                Divider(
                  height: r.stroke,
                  color: AppColors.muted.withValues(alpha: 0.4),
                ),
              _buildRow(r, items[i]),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildEmpty(Responsive r) {
    return Padding(
      padding: EdgeInsets.all(r.pad),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, size: r.icon * 2, color: AppColors.muted),
          SizedBox(height: r.gap),
          Text(
            'Belum ada laporan',
            style: AppTextStyles.regular(
              r.font(3.8),
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnTitles(Responsive r) {
    Text title(String text) =>
        Text(text, style: AppTextStyles.bold(r.font(3.4)));

    return Padding(
      padding: EdgeInsets.fromLTRB(r.gap, r.gap, r.gap, r.gapS),
      child: _RowLayout(
        title: title('Lokasi'),
        category: title('Kategori'),
        status: title('Status'),
        date: title('Tanggal'),
      ),
    );
  }

  Widget _buildRow(Responsive r, ReportData report) {
    return InkWell(
      onTap: () => onReportTap(report),
      child: Padding(
        padding: EdgeInsets.all(r.gap),
        child: _RowLayout(
          title: Text(
            report.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bold(r.font(3.6)),
          ),
          category: Text(
            report.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.medium(r.font(3.2), color: AppColors.textGrey),
          ),
          status: ReportStatusChip(status: report.status),
          date: Text(
            formatDate(report.createdAt),
            style: AppTextStyles.regular(
              r.font(3.2),
              color: AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}

class _RowLayout extends StatelessWidget {
  const _RowLayout({
    required this.title,
    required this.category,
    required this.status,
    required this.date,
  });

  final Widget title;
  final Widget category;
  final Widget status;
  final Widget date;

  @override
  Widget build(BuildContext context) {
    Widget left(Widget child) =>
        Align(alignment: Alignment.centerLeft, child: child);

    return Row(
      children: [
        Expanded(flex: 2, child: left(title)),
        Expanded(flex: 3, child: left(category)),
        Expanded(flex: 4, child: left(status)),
        Expanded(flex: 3, child: left(date)),
      ],
    );
  }
}
