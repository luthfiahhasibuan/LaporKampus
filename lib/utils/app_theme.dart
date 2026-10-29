import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primary = Color(0xFF4E693E);
  static const Color primaryDark = Color(0xFF3A5030);
  static const Color primaryLight = Color(0xFF6F8F5C);
  static const Color accent = Color(0xFFF7F7F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color golden = Color(0xFFDCB359);
  static const Color border = Color(0xFF6B705C);
  static const Color muted = Color.fromARGB(255, 182, 185, 171);
  static const Color background = Color(0xFFF0F4F1); // ganti sesuai warnamu
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF7F7F2);
  static const Color textDark = Color(0xFF252A1C);
  static const Color textGreen = Color(0xFF2D4030);
  static const Color textGrey = Color(0xFF6B705C);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x1A000000);
  static const Color error = Color(0xFFFF0000); // hitam 10%

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4E693E), Color(0xFF6F8F5A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 250, 161, 26),
      Color.fromARGB(255, 240, 193, 93),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle regular(
    double size, {
    Color color = AppColors.textDark,
    double? height,
  }) => _style(FontWeight.w400, size, color, height);

  static TextStyle medium(
    double size, {
    Color color = AppColors.textDark,
    double? height,
  }) => _style(FontWeight.w500, size, color, height);

  static TextStyle semibold(
    double size, {
    Color color = AppColors.textDark,
    double? height,
  }) => _style(FontWeight.w600, size, color, height);

  static TextStyle bold(
    double size, {
    Color color = AppColors.textDark,
    double? height,
  }) => _style(FontWeight.w700, size, color, height);

  static TextStyle _style(
    FontWeight weight,
    double size,
    Color color,
    double? height,
  ) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );
}

class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Poppins';
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)
        .copyWith(primary: AppColors.primary),
  );
}
