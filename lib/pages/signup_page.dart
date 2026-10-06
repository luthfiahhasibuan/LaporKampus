import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/app_scaffold.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Container(
            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),

                  child: Image.asset(
                    'assets/icon_app.png',
                    width: 80,
                    height: 80,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                const Text('LAPOR KAMPUS', style: AppTextStyles.authTitle),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Buat akun untuk mulai melapor',
                  style: TextStyle(color: AppColors.white),
                ),

                const SizedBox(height: 30),

                //NIM text field
                TextField(
                  style: AppTextStyles.fieldInput,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    labelText: 'NIM',
                    labelStyle: AppTextStyles.fieldLabel,
                    hintText: 'Masukkan NIM',
                    hintStyle: AppTextStyles.fieldHint,

                    prefixIcon: const Icon(Icons.person_outline),
                    prefixIconColor: AppColors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.golden,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                //Nama Lengkap Text Field
                TextField(
                  style: AppTextStyles.fieldInput,
                  keyboardType: TextInputType.text,

                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    labelStyle: AppTextStyles.fieldLabel,
                    hintText: 'Masukkan nama',
                    hintStyle: AppTextStyles.fieldHint,

                    prefixIcon: const Icon(Icons.person_outline),
                    prefixIconColor: AppColors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.golden,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Username Text Field
                TextField(
                  style: AppTextStyles.fieldInput,
                  keyboardType: TextInputType.text,

                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: AppTextStyles.fieldLabel,
                    hintText: 'Masukkan username',
                    hintStyle: AppTextStyles.fieldHint,

                    prefixIcon: const Icon(Icons.person_outline),
                    prefixIconColor: AppColors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.golden,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Password Text Field
                TextField(
                  obscureText: true,
                  style: AppTextStyles.fieldInput,

                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: AppTextStyles.fieldLabel,
                    hintText: 'Masukkan password kamu',
                    hintStyle: AppTextStyles.fieldHint,

                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: AppColors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.golden,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Konfirmasi Password Text Field
                TextField(
                  obscureText: true,
                  style: AppTextStyles.fieldInput,

                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    labelStyle: AppTextStyles.fieldLabel,
                    hintText: 'Ulangi password',
                    hintStyle: AppTextStyles.fieldHint,

                    prefixIcon: const Icon(Icons.person_outline),
                    prefixIconColor: AppColors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.golden,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed: () {
                      // Tidak ada fungsi karena halaman bersifat statis
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Daftar',
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Sudah punya akun? ',
                      style: TextStyle(color: Colors.white),
                    ),

                    GestureDetector(
                      onTap: () {
                        // Tidak ada fungsi karena halaman bersifat statis
                      },

                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: AppColors.golden,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
