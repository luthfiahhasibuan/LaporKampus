import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/app_routes.dart';
import '../models/user_model.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/profile_info_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final user = currentUser;

    return AppScaffold(
      body: SafeArea(
        child: user == null
            ? Center(
                child: Text(
                  'Belum ada pengguna yang masuk',
                  style: AppTextStyles.regular(
                    r.font(4),
                    color: AppColors.textGrey,
                  ),
                ),
              )
            : _buildBody(context, r, user),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Responsive r, UserModel user) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(r.pad),
      // Batasi lebar di layar lebar & tengahkan
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: r.maxWidth),
          child: Column(
            children: [
              _buildHeader(r, user),
              SizedBox(height: r.pad),
              _buildInfoCard(r, user),
              SizedBox(height: r.pad),
              _buildActionButton(
                r,
                icon: Icons.logout,
                label: 'Keluar',
                color: AppColors.error,
                onPressed: () => _confirmLogout(context),
              ),
              SizedBox(height: r.gap),
              _buildActionButton(
                r,
                icon: Icons.arrow_back,
                label: 'Kembali',
                color: AppColors.primary,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(
    Responsive r, {
    Color? color,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(r.radius),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: r.gap,
          offset: Offset(0, r.gapS),
        ),
      ],
    );
  }

  Widget _buildHeader(Responsive r, UserModel user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: r.sp(7), horizontal: r.pad),
      decoration: _cardDecoration(r, gradient: AppColors.primaryGradient),
      child: Column(
        children: [
          _buildAvatar(r, user),
          SizedBox(height: r.gap),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.bold(r.font(5.6), color: AppColors.white),
          ),
          SizedBox(height: r.gapS),
          Text(
            'NIM ${user.nim}',
            style: AppTextStyles.regular(r.font(3.6), color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(Responsive r, UserModel user) {
    return Container(
      width: r.sp(25),
      height: r.sp(25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.golden, width: r.strokeThick),
      ),
      child: Text(
        _initials(user.name),
        style: AppTextStyles.bold(r.font(8.7), color: AppColors.primary),
      ),
    );
  }

  Widget _buildInfoCard(Responsive r, UserModel user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: r.pad, vertical: r.gapS),
      decoration: _cardDecoration(r, color: AppColors.white),
      child: Column(
        children: [
          ProfileInfoTile(
            icon: Icons.badge_outlined,
            label: 'NIM',
            value: user.nim,
          ),
          Divider(height: r.stroke),
          ProfileInfoTile(
            icon: Icons.person_outline,
            label: 'Nama Lengkap',
            value: user.name,
          ),
          Divider(height: r.stroke),
          ProfileInfoTile(
            icon: Icons.alternate_email,
            label: 'Username',
            value: user.username,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    Responsive r, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: r.button,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(
          label,
          style: AppTextStyles.bold(r.font(4.1), color: color),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          side: BorderSide(color: color, width: r.strokeThick),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.radiusS),
          ),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';

    final second = parts.length > 1 ? parts[1][0] : '';
    return (parts.first[0] + second).toUpperCase();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final r = context.r;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text(
          'Kamu perlu masuk lagi untuk menggunakan aplikasi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              'Keluar',
              style: AppTextStyles.medium(r.font(3.6), color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    currentUser = null;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.signIn,
      (route) => false,
    );
  }
}
