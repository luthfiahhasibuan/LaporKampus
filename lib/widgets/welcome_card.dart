import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Selamat datang..', style: AppTextStyles.welcomeSubtitle),
          const SizedBox(height: 4),
          Text('Halo, $name!', style: AppTextStyles.welcomeTitle),
          const SizedBox(height: 5),
          Text(
            'Sampaikan laporan atau aspirasi kamu\n'
            'kepada pihak $universityName',
            style: AppTextStyles.welcomeBody,
          ),
        ],
      ),
    );
  }
}
