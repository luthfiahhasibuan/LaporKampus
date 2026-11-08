import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../data/dummy_data.dart';
import '../models/app_routes.dart';
import '../widgets/auth_text_field.dart';
import '../utils/responsive.dart';
import '../repositories/auth_repository.dart';

final _auth = AuthRepository();
bool _loading = false;

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final user = await _auth.signIn(
        username: _usernameC.text,
        password: _passC.text,
      );
      currentUser = user;
      if (!mounted) return;

      final destination = user.isAdmin ? AppRoutes.adminMain : AppRoutes.main;
      Navigator.pushNamedAndRemoveUntil(context, destination, (route) => false);
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: AppColors.error),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
                      onPressed: _loading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: _loading
                          ? SizedBox(
                              width: r.icon,
                              height: r.icon,
                              child: CircularProgressIndicator(
                                strokeWidth: r.strokeThick,
                                color: AppColors.primary,
                              ),
                            )
                          : Text(
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
