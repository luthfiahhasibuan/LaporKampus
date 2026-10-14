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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient, // gradient di sini
        border: Border.all(color: AppColors.white, width: 3),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 30,
            spreadRadius: 0,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor:
            Colors.transparent, // transparan agar gradient terlihat
        elevation: 0, // shadow sudah dipegang Container
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: AppColors.white),
      ),
    );
  }
}
