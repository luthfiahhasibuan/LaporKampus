import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class WelcomeCard extends StatelessWidget {
  final String name;
  final String universityName;

  const WelcomeCard({
    super.key,
    required this.name,
    required this.universityName,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat datang..',
            style: AppTextStyles.regular(r.font(4.1), color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            'Halo, $name!',
            style: AppTextStyles.bold(r.font(5.1), color: AppColors.white),
          ),
          const SizedBox(height: 5),
          Text(
            'Sampaikan laporan atau aspirasi kamu\n'
            'kepada pihak $universityName',
            style: AppTextStyles.regular(
              r.font(4.1),
              color: Colors.white70,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
