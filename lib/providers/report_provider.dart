import 'package:flutter/material.dart';

import '../models/report_data.dart';

enum ReportFilter {
  all('Semua', 'Belum ada laporan.'),
  sent('Terkirim', 'Belum ada laporan yang menunggu tanggapan.'),
  responded('Ditanggapi', 'Belum ada laporan yang ditanggapi.');

  const ReportFilter(this.label, this.emptyMessage);

  final String label;
  final String emptyMessage;

  bool matches(ReportData report) => switch (this) {
    ReportFilter.all => true,
    ReportFilter.sent => report.status == ReportStatus.sent,
    ReportFilter.responded => report.status == ReportStatus.responded,
  };
}

class ReportProvider extends ChangeNotifier {
  final List<ReportData> _reports = [];
  ReportFilter _filter = ReportFilter.all;

  List<ReportData> get reports => List.unmodifiable(_reports);

  // Statistik (dipakai halaman lain, misalnya beranda)
  int get total => _reports.length;
  int get sent => _reports.length;
  int get responded => countOf(ReportFilter.responded);

  // Filter halaman My Report
  ReportFilter get filter => _filter;

  List<ReportData> get filteredReports =>
      _reports.where(_filter.matches).toList();

  int countOf(ReportFilter filter) => _reports.where(filter.matches).length;

  void setFilter(ReportFilter filter) {
    if (filter == _filter) return;
    _filter = filter;
    notifyListeners();
  }

  void addReport(ReportData report) {
    _reports.insert(0, report);
    notifyListeners();
  }

  void updateStatus(ReportData report, String status) {
    report.status = status;
    notifyListeners();
  }
}
