import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

enum ReportStatus { terkirim, ditanggapi }

class RecentReport {
  final String title;
  final String category;
  final ReportStatus status;
  final DateTime date;

  const RecentReport({
    required this.title,
    required this.category,
    required this.status,
    required this.date,
  });
}

class RecentReportsCard extends StatelessWidget {
  final List<RecentReport> reports;

  const RecentReportsCard({super.key, required this.reports});

  static const _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String _formatDate(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$day ${_months[d.month - 1]} ${d.year}, $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    final items = reports.take(5).toList();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE3DA)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: const Row(
              children: [
                Icon(Icons.history, color: Colors.white, size: 24),
                SizedBox(width: 10),
                Text(
                  'Laporan Terbaru',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 60,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada laporan',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            )
          else ...[
            // Judul kolom
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 6),
              child: _RowLayout(
                judul: _HeaderText('Judul'),
                kategori: _HeaderText('Kategori'),
                status: _HeaderText('Status'),
                tanggal: _HeaderText('Tanggal'),
              ),
            ),
            // Baris data
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) const Divider(height: 1, color: Color(0xFFF1EAE3)),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: _RowLayout(
                  judul: Text(
                    items[i].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kategori: _Chip(
                    text: items[i].category,
                    background: const Color(0xFFF3F4F6),
                    foreground: Colors.black87,
                  ),
                  status: _StatusChip(status: items[i].status),
                  tanggal: Text(
                    _formatDate(items[i].date),
                    style: const TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Satu pengaturan lebar kolom untuk header dan baris agar selalu sejajar.
class _RowLayout extends StatelessWidget {
  final Widget judul;
  final Widget kategori;
  final Widget status;
  final Widget tanggal;

  const _RowLayout({
    required this.judul,
    required this.kategori,
    required this.status,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    Widget left(Widget w) => Align(alignment: Alignment.centerLeft, child: w);

    return Row(
      children: [
        Expanded(flex: 2, child: left(judul)),
        Expanded(flex: 3, child: left(kategori)),
        Expanded(flex: 4, child: left(status)),
        Expanded(flex: 3, child: left(tanggal)),
      ],
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final IconData? icon;

  const _Chip({
    required this.text,
    required this.background,
    required this.foreground,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final ReportStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ReportStatus.ditanggapi:
        return const _Chip(
          text: 'Ditanggapi',
          icon: Icons.check_circle_outline,
          background: Color(0xFFE8F8EE),
          foreground: Color(0xFF16A34A),
        );
      case ReportStatus.terkirim:
        return const _Chip(
          text: 'Terkirim',
          icon: Icons.send,
          background: Color(0xFFE6F0FF),
          foreground: Color(0xFF2563EB),
        );
    }
  }
}
