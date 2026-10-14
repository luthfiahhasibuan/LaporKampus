import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../widgets/app_header.dart';
import '../widgets/app_bottom_navigation.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({super.key});

  @override
  State<MyReportPage> createState() => _MyReportPageState();
}

String selectedFilter = 'Semua';
int _selectedNavIndex = 0;

class _MyReportPageState extends State<MyReportPage> {
  String selectedFilter = 'Semua';

  void _ubahStatus(Map<String, String> report) {
    setState(() {
      report['status'] = 'Selesai';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Status laporan berhasil diubah menjadi Selesai'),
      ),
    );
  }

  final List<Map<String, String>> reports = [
    {
      'title': 'Wi-Fi Kampus',
      'category': 'Fasilitas Kampus',
      'date': '14 Oktober 2026',
      'status': 'Diproses',
      'description': 'Koneksi Wi-Fi di beberapa ruang kelas sering terputus.',
    },
  ];

  List<Map<String, String>> get filteredReports {
    if (selectedFilter == 'Semua') {
      return reports;
    }

    return reports
        .where((report) => report['status'] == selectedFilter)
        .toList();
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Menunggu':
        return Colors.orange;

      case 'Diproses':
        return Colors.blue;

      case 'Selesai':
        return Colors.green;

      default:
        return AppColors.textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final waiting = reports.where((r) => r['status'] == 'Menunggu').length;
    final processing = reports.where((r) => r['status'] == 'Diproses').length;
    final completed = reports.where((r) => r['status'] == 'Selesai').length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Riwayat Laporan',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 6),
                    const Text(
                      'Pantau perkembangan laporan yang kamu kirim.',
                      style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                    ),

                    const SizedBox(height: 20),
                    // Ringkasan laporan
                    Row(
                      children: [
                        _summaryCard(
                          'Menunggu',
                          waiting,
                          Colors.orange,
                          Icons.hourglass_empty,
                        ),

                        const SizedBox(width: 8),
                        _summaryCard(
                          'Diproses',
                          processing,
                          Colors.blue,
                          Icons.sync,
                        ),

                        const SizedBox(width: 8),
                        _summaryCard(
                          'Selesai',
                          completed,
                          Colors.green,
                          Icons.check_circle_outline,
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      'Filter Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 12),
                    // Filter laporan
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: ['Semua', 'Menunggu', 'Diproses', 'Selesai']
                            .map((filter) {
                              final selected = selectedFilter == filter;

                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text(filter),
                                  selected: selected,
                                  selectedColor: AppColors.primary,
                                  backgroundColor: AppColors.white,
                                  labelStyle: TextStyle(
                                    color: selected
                                        ? AppColors.white
                                        : AppColors.textDark,

                                    fontWeight: FontWeight.w600,
                                  ),

                                  onSelected: (_) {
                                    setState(() {
                                      selectedFilter = filter;
                                    });
                                  },
                                ),
                              );
                            })
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'Daftar Laporan (${filteredReports.length})',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Daftar laporan
                    if (filteredReports.isEmpty)
                      _emptyState()
                    else
                      ...filteredReports.map((report) => _reportCard(report)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _summaryCard(String title, int count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          children: [
            Icon(icon, color: color, size: 25),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),

            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                title,
                style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportCard(Map<String, String> report) {
    final status = report['status'] ?? 'Menunggu';
    final color = statusColor(status);

    return Card(
      color: AppColors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showReportDetail(report),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Icon(
                      Icons.description_outlined,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),

                        const SizedBox(height: 5),
                        Text(
                          report['category'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(Icons.chevron_right, color: AppColors.textGrey),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColors.textGrey,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      report['date'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.inbox_outlined, size: 60, color: AppColors.textGrey),
          SizedBox(height: 12),
          Text(
            'Belum Ada Laporan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          SizedBox(height: 6),
          Text(
            'Laporan dengan status ini belum tersedia.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  void _showReportDetail(Map<String, String> report) {
    final status = report['status'] ?? 'Menunggu';
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(report['title'] ?? 'Detail Laporan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Kategori: ${report['category'] ?? '-'}'),
              const SizedBox(height: 8),
              Text('Tanggal: ${report['date'] ?? '-'}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Status: '),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                'Deskripsi:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),
              Text(report['description'] ?? '-'),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),

          if (status != 'Selesai')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _ubahStatus(report);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),

              child: const Text('Tandai Selesai'),
            ),
        ],
      ),
    );
  }
}
