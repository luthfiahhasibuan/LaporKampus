import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
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

  List<ReportData> get reports {
    final user = currentUser;
    if (user == null) return const <ReportData>[];
    if (user.isAdmin) return List.unmodifiable(_reports);
    return List.unmodifiable(
      _reports.where((report) => report.reporter.nim == user.nim),
    );
  }

  // Statistik (dipakai beranda dan dashboard admin)
  int get total => reports.length;
  int get sent => reports.length;
  int get responded => countOf(ReportFilter.responded);

  // Filter halaman daftar laporan
  ReportFilter get filter => _filter;

  List<ReportData> get filteredReports =>
      reports.where(_filter.matches).toList();

  List<ReportData> get pendingReports =>
      reports.where(ReportFilter.sent.matches).toList();

  int countOf(ReportFilter filter) => reports.where(filter.matches).length;

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
    if (status == ReportStatus.sent) {
      report.response = null;
      report.respondedAt = null;
    }
    notifyListeners();
  }

  void respond(ReportData report, String response) {
    report.response = response.trim();
    report.respondedAt = DateTime.now();
    report.status = ReportStatus.responded;
    notifyListeners();
  }
}
