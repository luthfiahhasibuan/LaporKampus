import 'package:flutter/material.dart';

import '../models/report.dart';

class ReportProvider extends ChangeNotifier {
  final List<Report> _reports = [];

  List<Report> get reports => List.unmodifiable(_reports);
  int get total => _reports.length;
  int get sent => _reports.where((r) => r.status != ReportStatus.draft).length;
  int get responded =>
      _reports.where((r) => r.status == ReportStatus.responded).length;

  void addReport(String title) {
    _reports.add(
      Report(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
      ),
    );
    notifyListeners(); // memberi tahu widget yang mendengarkan
  }

  void updateStatus(String id, ReportStatus status) {
    final index = _reports.indexWhere((r) => r.id == id);
    if (index == -1) return;
    _reports[index] = _reports[index].copyWith(status: status);
    notifyListeners();
  }
}
