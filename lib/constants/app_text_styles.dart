import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semua gaya teks aplikasi disimpan di sini.
/// Pakai: Text('Halo', style: AppTextStyles.welcomeTitle)
class AppTextStyles {
  AppTextStyles._();

  // Header
  static const TextStyle appTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  // Welcome card
  static const TextStyle welcomeSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textGrey,
  );
  static const TextStyle welcomeTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textGreen,
  );
  static const TextStyle welcomeBody = TextStyle(
    fontSize: 16,
    height: 1.4,
    color: AppColors.textGrey,
  );

  // Statistik
  static const TextStyle statNumber = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle statLabel = TextStyle(
    fontSize: 10,
    color: AppColors.textGrey,
  );

  // Menu card
  static const TextStyle menuTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static const TextStyle menuSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.white,
  );

  // Bottom navigation
  static const TextStyle navLabel = TextStyle(
    fontSize: 7,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
  );
  static const TextStyle navLabelSelected = TextStyle(
    fontSize: 7,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
