import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../models/app_routes.dart';
import '../utils/responsive.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/icon_app.png', width: 55, height: 55),
          const SizedBox(width: 10),
          Text('LAPOR KAMPUS', style: AppTextStyles.bold(r.font(5.6))),
          const Spacer(),
          const _Avatar(),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.golden,
          border: Border.all(color: AppColors.white, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text('🧟‍♀️', style: TextStyle(fontSize: 23)),
        ),
      ),
    );
  }
}
