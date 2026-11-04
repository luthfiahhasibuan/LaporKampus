import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.gap),
      child: Row(
        children: [
          _buildIconBadge(r),
          SizedBox(width: r.gap),
          Expanded(child: _buildTexts(r)),
        ],
      ),
    );
  }

  Widget _buildIconBadge(Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.gapS),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(r.radiusS),
      ),
      child: Icon(icon, color: AppColors.primary, size: r.icon),
    );
  }

  Widget _buildTexts(Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.regular(r.font(3.1), color: AppColors.textGrey),
        ),
        Text(value, style: AppTextStyles.semibold(r.font(4.1))),
      ],
    );
  }
}
