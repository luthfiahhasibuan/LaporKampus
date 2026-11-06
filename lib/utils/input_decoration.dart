import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'responsive.dart';

InputDecoration appInputDecoration(
  Responsive r, {
  String? hint,
  IconData? icon,
}) {
  OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(r.radiusS),
    borderSide: BorderSide(color: color, width: width),
  );

  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.regular(r.font(3.6), color: AppColors.textGrey),
    prefixIcon: icon == null ? null : Icon(icon),
    prefixIconColor: AppColors.primary,
    filled: true,
    fillColor: AppColors.primary.withValues(alpha: 0.04),
    contentPadding: EdgeInsets.all(r.gap),
    enabledBorder: border(AppColors.border, r.stroke),
    focusedBorder: border(AppColors.primary, r.strokeThick),
  );
}
