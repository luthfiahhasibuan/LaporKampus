import 'dart:io' show File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

/// Menampilkan foto lampiran laporan dari [path].
/// Di web path berupa URL blob, di mobile berupa path file.
class ReportImage extends StatelessWidget {
  const ReportImage({super.key, required this.path, required this.height});

  final String path;
  final double height;

  @override
  Widget build(BuildContext context) {
    final image = kIsWeb
        ? Image.network(
            path,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: _error,
          )
        : Image.file(
            File(path),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: _error,
          );

    return image;
  }

  Widget _error(BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.surfaceMuted,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image_outlined, color: AppColors.textGrey),
    );
  }
}
