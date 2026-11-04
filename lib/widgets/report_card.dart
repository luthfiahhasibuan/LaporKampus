import 'package:flutter/material.dart';

import '../models/report_data.dart';
import '../utils/app_theme.dart';
import '../utils/date_format.dart';
import '../utils/report_category.dart';
import '../utils/responsive.dart';
import 'app_card.dart';
import 'report_status_chip.dart';

/// Kartu ringkas satu laporan di daftar My Report.
class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report, required this.onTap});

  final ReportData report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return AppCard(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(r.gap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(r.gapS),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    reportCategoryIcon(report.category),
                    color: AppColors.primary,
                    size: r.icon,
                  ),
                ),
                SizedBox(width: r.gap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bold(r.font(4.2)),
                      ),
                      SizedBox(height: r.gapS / 2),
                      Text(
                        '${report.category} · ${formatDate(report.createdAt)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regular(
                          r.font(3.4),
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: r.gapS),
                ReportStatusChip(status: report.status),
              ],
            ),
            SizedBox(height: r.gapS * 1.5),
            Text(
              report.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.regular(
                r.font(3.6),
                color: AppColors.textGrey,
                height: 1.4,
              ),
            ),
            SizedBox(height: r.gapS),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Lihat detail',
                  style: AppTextStyles.semibold(
                    r.font(3.6),
                    color: AppColors.primary,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: r.icon,
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
