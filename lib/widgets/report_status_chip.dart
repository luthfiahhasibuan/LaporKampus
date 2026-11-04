import 'package:flutter/material.dart';

import '../models/report_data.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class ReportStatusChip extends StatelessWidget {
  const ReportStatusChip({super.key, required this.status});

  final String status;

  static const Color _sentText = Color(0xFF8A6A1F);

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final responded = status == ReportStatus.responded;

    final foreground = responded ? AppColors.primary : _sentText;
    final background = responded
        ? AppColors.primary.withValues(alpha: 0.12)
        : AppColors.golden.withValues(alpha: 0.25);
    final icon = responded ? Icons.check_circle_outline : Icons.send_outlined;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.gapS * 1.5,
        vertical: r.gapS / 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(r.radius * 5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: r.font(3.6), color: foreground),
          SizedBox(width: r.gapS / 2),
          Text(
            status,
            style: AppTextStyles.semibold(r.font(3.2), color: foreground),
          ),
        ],
      ),
    );
  }
}
