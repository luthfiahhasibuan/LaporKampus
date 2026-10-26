import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../data/dummy_data.dart';
import '../models/app_routes.dart';
import '../widgets/auth_text_field.dart';
import '../utils/responsive.dart';

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
      // apakah username-nya terdaftar atau tidak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (index == -1) {
      // ...snackbar error...
      return;
    }

    currentUser = dummyUsers[index];

    // Login berhasil -> masuk ke halaman utama
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
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
                  Text(
                    'LAPOR KAMPUS',
                    style: AppTextStyles.bold(
                      r.font(7.2),
                      color: AppColors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Silakan masuk ke akun kamu',
                    style: TextStyle(color: AppColors.white),
                  ),

                  const SizedBox(height: 30),

                  AuthTextField(
                    controller: _usernameC,
                    label: 'Username',
                    hint: 'Masukkan username kamu',
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.text,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Username tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 18),

                  AuthTextField(
                    controller: _passC,
                    label: 'Password',
                    hint: 'Masukkan password kamu',
                    icon: Icons.lock_outline,
                    obscureText: true,
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

                      child: Text(
                        'Masuk',
                        style: AppTextStyles.bold(
                          r.font(4.4),
                          color: AppColors.primary,
                        ),
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
