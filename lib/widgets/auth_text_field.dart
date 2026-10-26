import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/responsive.dart';

/// Text field bergaya auth (border putih, fokus emas) yang dipakai ulang
/// di halaman Sign In dan Sign Up.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.regular(r.font(4), color: AppColors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.regular(r.font(4), color: AppColors.white),
        hintText: hint,
        hintStyle: AppTextStyles.regular(r.font(4), color: AppColors.white),
        prefixIcon: Icon(icon),
        prefixIconColor: AppColors.white,
        enabledBorder: _border(AppColors.white),
        focusedBorder: _border(AppColors.golden),
      ),
      validator: validator,
    );
  }
}
