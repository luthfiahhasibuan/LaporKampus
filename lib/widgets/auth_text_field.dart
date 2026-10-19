import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.fieldInput,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.fieldLabel,
        hintText: hint,
        hintStyle: AppTextStyles.fieldHint,
        prefixIcon: Icon(icon),
        prefixIconColor: AppColors.white,
        enabledBorder: _border(AppColors.white),
        focusedBorder: _border(AppColors.golden),
      ),
      validator: validator,
    );
  }
}
