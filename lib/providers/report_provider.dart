import 'package:flutter/material.dart';

import '../models/report_data.dart';

class ReportProvider extends ChangeNotifier {
  final List<ReportData> _reports = [];

  List<ReportData> get reports => List.unmodifiable(_reports);

  int get total => _reports.length;
  int get sent => _reports.length;
  int get responded => _reports
      .where(
        (report) => report.status == 'Diproses' || report.status == 'Selesai',
      )
      .length;

  void addReport(ReportData report) {
    _reports.insert(0, report);
    notifyListeners();
  }

  void updateStatus(ReportData report, String status) {
    report.status = status;
    notifyListeners();
  }
}
