import 'package:flutter/material.dart';

import '../providers/report_provider.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class ReportFilterTabs extends StatelessWidget {
  const ReportFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.countOf,
  });

  final ReportFilter selected;
  final ValueChanged<ReportFilter> onChanged;
  final int Function(ReportFilter filter) countOf;

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return Container(
      padding: EdgeInsets.all(r.gapS / 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(r.radius),
        border: Border.all(color: AppColors.muted, width: r.stroke),
      ),
      child: Row(
        children: [
          for (final filter in ReportFilter.values)
            Expanded(
              child: _FilterTab(
                label: filter.label,
                count: countOf(filter),
                selected: filter == selected,
                onTap: () => onChanged(filter),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final textColor = selected ? AppColors.white : AppColors.textGrey;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: r.gapS * 1.3),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(r.radius * 0.75),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.semibold(r.font(3.6), color: textColor),
              ),
              SizedBox(width: r.gapS / 2),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.gapS * 0.9,
                  vertical: r.gapS / 5,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.white.withValues(alpha: 0.25)
                      : AppColors.muted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(r.radius * 5),
                ),
                child: Text(
                  '$count',
                  style: AppTextStyles.semibold(r.font(3.2), color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
