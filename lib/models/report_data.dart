import 'user_model.dart';

class ReportStatus {
  ReportStatus._();

  static const String sent = 'Terkirim';
  static const String responded = 'Ditanggapi';
}

class ReportData {
  final String faculty;
  final String title;
  final String category;
  final String description;
  final String? imagePath;
  final UserModel reporter;
  final DateTime createdAt;

  String status;

  String? response;
  DateTime? respondedAt;

  ReportData({
    required this.faculty,
    required this.title,
    required this.category,
    required this.description,
    required this.reporter,
    this.imagePath,
    this.status = ReportStatus.sent,
    this.response,
    this.respondedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isResponded => status == ReportStatus.responded;
}
