import 'package:flutter/material.dart';

/// Semua warna aplikasi disimpan di sini.
/// Pakai: AppColors.primary
class AppColors {
  AppColors._(); // mencegah class ini di-instantiate

  static const Color primary = Color(0xFF4E693E);
  static const Color accent = Color(0xFFF7F7F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color golden = Color(0xFFDCB359);
  static const Color border = Color(0xFF6B705C);

  // Latar belakang
  static const Color background = Color(0xFFF2F4EF); // ganti sesuai warnamu
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF7F7F2);

  // Teks
  static const Color textDark = Color(0xFF252A1C);
  static const Color textGreen = Color(0xFF2D4030);
  static const Color textGrey = Color(0xFF6B705C);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Bayangan
  static const Color shadow = Color(0x1A000000); // hitam 10%
}
