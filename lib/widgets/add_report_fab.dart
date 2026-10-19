import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AddReportFab extends StatelessWidget {
  final VoidCallback onPressed;

  const AddReportFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 4),

        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),

      child: SizedBox(
        width: 59,
        height: 59,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: AppColors.white,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32, color: AppColors.primary),
        ),
      ),
    );
  }
}
