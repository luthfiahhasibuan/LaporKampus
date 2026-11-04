class ReportStatus {
  ReportStatus._();

  static const String sent = 'Terkirim';
  static const String responded = 'Ditanggapi';
}

class ReportData {
  final String title;
  final String category;
  final String description;
  final String? imagePath;
  String status;
  final DateTime createdAt;

  /// Tanggapan dari petugas (hanya ada jika status = Ditanggapi).
  final String? response;
  final DateTime? respondedAt;

  ReportData({
    required this.title,
    required this.category,
    required this.description,
    this.imagePath,
    this.status = ReportStatus.sent,
    this.response,
    this.respondedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isResponded => status == ReportStatus.responded;
}
