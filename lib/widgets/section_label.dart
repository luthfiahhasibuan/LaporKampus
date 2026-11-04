import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

/// Judul kecil berikon di atas setiap bagian form / detail.
class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return Padding(
      padding: EdgeInsets.only(bottom: r.gapS),
      child: Row(
        children: [
          Icon(icon, size: r.gap, color: AppColors.primary),
          SizedBox(width: r.gapS),
          Text(text, style: AppTextStyles.bold(r.font(3.8))),
        ],
      ),
    );
  }
}
