import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AddReportFab extends StatelessWidget {
  final VoidCallback onPressed;

  const AddReportFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: AppColors.white),
      ),
    );
  }
}
