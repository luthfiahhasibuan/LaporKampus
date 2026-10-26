import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../models/app_routes.dart';
import '../data/dummy_data.dart';
import '../models/user_model.dart';
import '../widgets/auth_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nimC = TextEditingController();
  final _nameC = TextEditingController();
  final _usernameC = TextEditingController();
  final _passC = TextEditingController();
  final _confirmC = TextEditingController();

  @override
  void dispose() {
    _nimC.dispose();
    _nameC.dispose();
    _usernameC.dispose();
    _passC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  void _showMessage(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final nim = _nimC.text.trim();
    final username = _usernameC.text.trim();

    // NIM tidak boleh dipakai dua kali
    if (dummyUsers.any((u) => u.nim == nim)) {
      _showMessage('NIM sudah terdaftar');
      return;
    }

    // Username tidak boleh dipakai dua kali (tidak peka huruf besar/kecil)
    if (dummyUsers.any(
      (u) => u.username.toLowerCase() == username.toLowerCase(),
    )) {
      _showMessage('Username sudah dipakai');
      return;
    }

    dummyUsers.add(
      UserModel(
        nim: nim,
        name: _nameC.text.trim(),
        username: username,
        password: _passC.text,
      ),
    );

    _showMessage('Pendaftaran berhasil! Silakan masuk', isError: false);

    // Daftar berhasil -> ke halaman Sign In
    Navigator.pushReplacementNamed(context, AppRoutes.signIn);
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
                  Text('LAPOR KAMPUS', style: AppTextStyles.bold(r.font(7.2), color: AppColors.white),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Buat akun untuk mulai melapor',
                    style: TextStyle(color: AppColors.white),
                  ),

                  const SizedBox(height: 30),

                  // NIM text field
                  AuthTextField(
                    controller: _nimC,
                    label: 'Nim',
                    hint: 'Masukkan NIM kamu',
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'NIM tidak boleh kosong'
                        : null,
                  ),

                  const SizedBox(height: 18),

                  AuthTextField(
                    controller: _nameC,
                    label: 'Name',
                    hint: 'Masukkan nama kamu',
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.text,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Nama tidak boleh kosong'
                        : null,
                  ),

                  const SizedBox(height: 18),

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

                  const SizedBox(height: 18),

                  AuthTextField(
                    controller: _passC,
                    label: 'Ulangi password',
                    hint: 'Musukkan password kamu',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Password tidak boleh kosong'
                        : null,
                  ),

                  const SizedBox(height: 18),

                  // Daftar Button
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
                        'Daftar',
                        style: AppTextStyles.bold(r.font(4.4), color: AppColors.primary),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style: TextStyle(color: Colors.white),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signIn,
                          );
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
      ),
    );
  }
}
