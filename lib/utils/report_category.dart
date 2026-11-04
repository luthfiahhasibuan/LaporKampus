import 'package:flutter/material.dart';

/// Daftar kategori laporan beserta ikonnya.
/// Dipakai di form buat laporan, kartu laporan, dan halaman detail.
const Map<String, IconData> reportCategories = {
  'Fasilitas': Icons.apartment_outlined,
  'Akademik': Icons.school_outlined,
  'Kebersihan': Icons.cleaning_services_outlined,
  'Keamanan': Icons.shield_outlined,
  'Lainnya': Icons.more_horiz,
};

IconData reportCategoryIcon(String category) =>
    reportCategories[category] ?? Icons.description_outlined;
