import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/app_scaffold.dart';
import '../data/dummy_data.dart';
import '../models/app_routes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameC = TextEditingController();
  final _passC = TextEditingController();

  @override
  void dispose() {
    _usernameC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _submit() {
    // Jalankan semua validator; berhenti jika ada yang error
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameC.text.trim().toLowerCase();
    final pass = _passC.text;

    // Cocokkan username DAN password ke dummy data
    final index = dummyUsers.indexWhere(
      (u) => u.username.toLowerCase() == username && u.password == pass,
    );

    if (index == -1) {
      // Pesan sengaja dibuat umum agar tidak membocorkan
      // apakah username-nya terdaftar atau tidak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Login berhasil -> masuk ke halaman utama
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Container(
            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Form(
              key: _formKey,

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
                    'Silakan masuk ke akun kamu',
                    style: TextStyle(color: AppColors.white),
                  ),

                  const SizedBox(height: 30),

                  // Username Text Field
                  TextFormField(
                    controller: _usernameC,
                    style: AppTextStyles.fieldInput,
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: AppTextStyles.fieldLabel,
                      hintText: 'Masukkan username kamu',
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

                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Username tidak boleh kosong'
                        : null,
                  ),

                  const SizedBox(height: 18),

                  // Password Text Field
                  TextFormField(
                    controller: _passC,
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

                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Password tidak boleh kosong'
                        : null,
                  ),

                  const SizedBox(height: 25),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: _submit,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        'Masuk',
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
                        'Belum punya akun? ',
                        style: TextStyle(color: Colors.white),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signUp,
                          );
                        },

                        child: const Text(
                          'Daftar',
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
      ),
    );
  }
}
