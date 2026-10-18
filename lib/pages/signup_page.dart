import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/app_scaffold.dart';
import '../models/app_routes.dart';
import '../data/dummy_data.dart';
import '../models/user_model.dart';
import '../utils/validators.dart';

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
    // Jalankan semua validator; berhenti jika ada yang error
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

    // Simpan ke dummy data
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
                  const Text('LAPOR KAMPUS', style: AppTextStyles.authTitle),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Buat akun untuk mulai melapor',
                    style: TextStyle(color: AppColors.white),
                  ),

                  const SizedBox(height: 30),

                  // NIM text field
                  TextFormField(
                    controller: _nimC,
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
                    validator: Validators.nim,
                  ),

                  const SizedBox(height: 18),

                  // Nama Lengkap Text Field
                  TextFormField(
                    controller: _nameC,
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
                    validator: Validators.name,
                  ),

                  const SizedBox(height: 18),

                  // Username Text Field
                  TextFormField(
                    controller: _usernameC,
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
                    validator: Validators.username,
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
                    validator: Validators.password,
                  ),

                  const SizedBox(height: 25),

                  // Konfirmasi Password Text Field
                  TextFormField(
                    controller: _confirmC,
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
                    validator: (v) =>
                        Validators.confirmPassword(v, _passC.text),
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
                        style: AppTextStyles.buttonText,
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
