import 'package:flutter/material.dart';

import '../models/report_data.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({super.key});

  @override
  State<MyReportPage> createState() => _MyReportPageState();
}

class _MyReportPageState extends State<MyReportPage> {
  String selectedFilter = 'Semua';

  List<ReportData> get reports => DummyReportStore.reports;

  List<ReportData> get filteredReports {
    if (selectedFilter == 'Semua') {
      return reports;
    }

    return reports.where((report) => report.status == selectedFilter).toList();
  }

  void _ubahStatus(ReportData report) {
    setState(() {
      report.status = 'Selesai';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Status laporan berhasil diubah menjadi Selesai'),
      ),
    );
  }

  Widget _reportCard(ReportData report) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text('Kategori: ${report.category}'),
            const SizedBox(height: 6),
            Text(report.description),
            const SizedBox(height: 8),
            Text(
              'Tanggal: ${report.createdAt.day}/'
              '${report.createdAt.month}/'
              '${report.createdAt.year}',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Status: '),
                Chip(
                  label: Text(report.status),
                  backgroundColor: report.status == 'Selesai'
                      ? Colors.green.shade100
                      : report.status == 'Diproses'
                      ? Colors.orange.shade100
                      : Colors.blue.shade100,
                ),
                const Spacer(),
                if (report.status != 'Selesai')
                  IconButton(
                    tooltip: 'Ubah menjadi Selesai',
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => _ubahStatus(report),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Saya')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              initialValue: selectedFilter,
              decoration: const InputDecoration(
                labelText: 'Filter Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Semua', child: Text('Semua Laporan')),
                DropdownMenuItem(value: 'Menunggu', child: Text('Menunggu')),
                DropdownMenuItem(value: 'Diproses', child: Text('Diproses')),
                DropdownMenuItem(value: 'Selesai', child: Text('Selesai')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedFilter = value;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: filteredReports.isEmpty
                ? const Center(child: Text('Belum ada laporan.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredReports.length,
                    itemBuilder: (context, index) {
                      return _reportCard(filteredReports[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
