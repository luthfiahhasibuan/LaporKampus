import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../models/app_routes.dart';
import '../widgets/auth_text_field.dart';
import '../utils/responsive.dart';
import '../repositories/auth_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  final _nimC = TextEditingController();
  final _nameC = TextEditingController();
  final _usernameC = TextEditingController();
  final _passC = TextEditingController();
  final _confirmC = TextEditingController();

  bool _loading = false;

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
        backgroundColor: isError ? AppColors.error : AppColors.primary,
      ),
    );
  }

  String? _required(String? value, String message) =>
      (value == null || value.trim().isEmpty) ? message : null;

  String? _validateUsername(String? value) {
    final username = value?.trim() ?? '';
    if (username.isEmpty) return 'Username tidak boleh kosong';
    // Username dijadikan email internal, jadi karakternya dibatasi.
    if (!RegExp(r'^[A-Za-z0-9._]{3,}$').hasMatch(username)) {
      return 'Minimal 3 karakter: huruf, angka, titik, atau garis bawah';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Ulangi password kamu';
    if (value != _passC.text) return 'Password tidak sama';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await _auth.signUp(
        nim: _nimC.text,
        name: _nameC.text,
        username: _usernameC.text,
        password: _passC.text,
      );

      await _auth.signOut();
      if (!mounted) return;

      _showMessage('Pendaftaran berhasil! Silakan masuk', isError: false);
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
    } on AuthException catch (e) {
      if (!mounted) return;
      _showMessage(e.message);
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
          padding: EdgeInsets.all(r.pad),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: r.maxWidth),
            child: Container(
              padding: EdgeInsets.all(r.pad),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(r.radius),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: r.gap,
                    offset: Offset(0, r.gapS),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(r),
                    SizedBox(height: r.pad),
                    _buildFields(r),
                    SizedBox(height: r.pad),
                    _buildSubmitButton(r),
                    SizedBox(height: r.pad),
                    _buildLoginLink(r),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Responsive r) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(r.gap),
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/icon_app.png',
            width: r.sp(20),
            height: r.sp(20),
          ),
        ),
        SizedBox(height: r.pad),
        Text(
          'LAPOR KAMPUS',
          style: AppTextStyles.bold(r.font(7.2), color: AppColors.white),
        ),
        SizedBox(height: r.gapS),
        Text(
          'Buat akun untuk mulai melapor',
          style: AppTextStyles.regular(r.font(4), color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildFields(Responsive r) {
    return Column(
      spacing: r.pad,
      children: [
        AuthTextField(
          controller: _nimC,
          label: 'NIM',
          hint: 'Masukkan NIM kamu',
          icon: Icons.person_outline,
          keyboardType: TextInputType.number,
          validator: (v) => _required(v, 'NIM tidak boleh kosong'),
        ),
        AuthTextField(
          controller: _nameC,
          label: 'Nama',
          hint: 'Masukkan nama kamu',
          icon: Icons.person_outline,
          keyboardType: TextInputType.text,
          validator: (v) => _required(v, 'Nama tidak boleh kosong'),
        ),
        AuthTextField(
          controller: _usernameC,
          label: 'Username',
          hint: 'Masukkan username kamu',
          icon: Icons.person_outline,
          keyboardType: TextInputType.text,
          validator: _validateUsername,
        ),
        AuthTextField(
          controller: _passC,
          label: 'Password',
          hint: 'Masukkan password kamu',
          icon: Icons.lock_outline,
          obscureText: true,
          validator: _validatePassword,
        ),
        AuthTextField(
          controller: _confirmC,
          label: 'Ulangi password',
          hint: 'Masukkan ulang password kamu',
          icon: Icons.lock_outline,
          obscureText: true,
          validator: _validateConfirm,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(Responsive r) {
    return SizedBox(
      width: double.infinity,
      height: r.button,
      child: ElevatedButton(
        onPressed: _loading ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.radiusS),
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
                'Daftar',
                style: AppTextStyles.bold(
                  r.font(4.4),
                  color: AppColors.primary,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginLink(Responsive r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sudah punya akun? ',
          style: AppTextStyles.regular(r.font(3.8), color: AppColors.white),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.signIn),
          child: Text(
            'Masuk',
            style: AppTextStyles.bold(r.font(3.8), color: AppColors.golden),
          ),
        ),
      ],
    );
  }
}
