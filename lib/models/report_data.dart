class ReportData {
  final String title;
  final String category;
  final String description;
  final String? imagePath;
  String status;
  final DateTime createdAt;

  ReportData({
    required this.title,
    required this.category,
    required this.description,
    this.imagePath,
    this.status = 'Menunggu',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class DummyReportStore {
  // Tempat menyimpan semua laporan
  static final List<ReportData> reports = [
    ReportData(
      title: 'Wi-Fi Kampus',
      category: 'Fasilitas Kampus',
      description: 'Koneksi Wi-Fi di beberapa ruang kelas sering terputus.',
      status: 'Diproses',
      createdAt: DateTime(2026, 10, 14),
    ),
  ];

  // Menambahkan laporan baru
  static void addReport(ReportData report) {
    reports.insert(0, report);
  }
}
