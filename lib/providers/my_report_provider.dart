// import 'package:flutter/foundation.dart';

// import '../models/report_data.dart';

// // Kategori filter di halaman My Report
// enum ReportFilter {
//   all('Semua', 'Belum ada laporan.'),
//   sent('Terkirim', 'Belum ada laporan yang menunggu tanggapan.'),
//   responded('Ditanggapi', 'Belum ada laporan yang ditanggapi.');

//   const ReportFilter(this.label, this.emptyMessage);

//   final String label;
//   final String emptyMessage;

//   bool matches(ReportData report) => switch (this) {
//     ReportFilter.all => true,
//     ReportFilter.sent => report.status == ReportStatus.sent,
//     ReportFilter.responded => report.status == ReportStatus.responded,
//   };
// }

// // State halaman My Report
// class MyReportProvider extends ChangeNotifier {
//   ReportFilter _filter = ReportFilter.all;

//   ReportFilter get filter => _filter;

//   List<ReportData> get reports => DummyReportStore.reports;

//   List<ReportData> get filteredReports =>
//       reports.where(_filter.matches).toList();

//   int countOf(ReportFilter filter) => reports.where(filter.matches).length;

//   void setFilter(ReportFilter filter) {
//     if (filter == _filter) return;
//     _filter = filter;
//     notifyListeners();
//   }

//   void addReport(ReportData report) {
//     DummyReportStore.addReport(report);
//     notifyListeners();
//   }
// }
