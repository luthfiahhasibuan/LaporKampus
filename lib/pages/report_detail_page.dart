import 'package:flutter/material.dart';

import '../models/report_data.dart';
import '../utils/app_theme.dart';
import '../utils/date_format.dart';
import '../utils/report_category.dart';
import '../utils/responsive.dart';
import '../widgets/app_card.dart';
import '../widgets/app_header.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/gradient_card_header.dart';
import '../widgets/report_image.dart';
import '../widgets/report_status_chip.dart';
import '../widgets/section_label.dart';

import 'package:provider/provider.dart';

import '../providers/report_provider.dart';
import '../widgets/admin_response_panel.dart';

class ReportDetailPage extends StatelessWidget {
  const ReportDetailPage({
    super.key,
    required this.report,
    this.isAdmin = false,
  });

  final ReportData report;
  final bool isAdmin;

  static Future<void> open(
    BuildContext context,
    ReportData report, {
    bool isAdmin = false,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ReportDetailPage(report: report, isAdmin: isAdmin),
      ),
    );
  }

  Widget _buildReporter(Responsive r) {
    final reporter = report.reporter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(icon: Icons.person_outline, text: 'Pelapor'),
        Text(reporter.name, style: AppTextStyles.regular(r.font(3.8))),
        SizedBox(height: r.font(1.8)),
        Text(
          'NIM ${reporter.nim}',
          style: AppTextStyles.regular(r.font(3.6), color: AppColors.textGrey),
        ),
        SizedBox(height: r.pad),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    context.watch<ReportProvider>();
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(r.pad, r.gapS, r.pad, r.bottom),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: r.maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBackButton(context, r),
                        SizedBox(height: r.gapS),
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientCardHeader(
                                icon: reportCategoryIcon(report.category),
                                title: report.title,
                                subtitle: report.category,
                              ),
                              _buildBody(r),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, Responsive r) {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back, size: r.icon),
      label: Text(
        'Kembali',
        style: AppTextStyles.semibold(r.font(3.8), color: AppColors.primary),
      ),
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    );
  }

  Widget _buildBody(Responsive r) {
    final imagePath = report.imagePath;

    return Padding(
      padding: EdgeInsets.all(r.pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ReportStatusChip(status: report.status),
              const Spacer(),
              Icon(
                Icons.calendar_today_outlined,
                size: r.font(3.6),
                color: AppColors.textGrey,
              ),
              SizedBox(width: r.gapS / 2),
              Text(
                formatDate(report.createdAt),
                style: AppTextStyles.regular(
                  r.font(3.6),
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),

          SizedBox(height: r.pad),

          if (isAdmin) ...[SizedBox(height: r.pad), _buildReporter(r)],

          const SectionLabel(
            icon: Icons.school_outlined,
            text: 'Fakultas / Program Studi',
          ),
          Text(report.faculty, style: AppTextStyles.regular(r.font(3.8))),
          SizedBox(height: r.pad),

          // Isi laporan
          const SectionLabel(icon: Icons.notes_outlined, text: 'Isi Laporan'),
          Text(
            report.description,
            style: AppTextStyles.regular(r.font(3.8), height: 1.5),
          ),

          // Foto lampiran (opsional)
          if (imagePath != null) ...[
            SizedBox(height: r.pad),
            const SectionLabel(
              icon: Icons.image_outlined,
              text: 'Lampiran Foto',
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(r.radiusS),
              child: ReportImage(path: imagePath, height: r.sp(50)),
            ),
          ],

          SizedBox(height: r.pad),

          // Tanggapan petugas
          if (isAdmin)
            AdminResponsePanel(report: report)
          else ...[
            const SectionLabel(
              icon: Icons.question_answer_outlined,
              text: 'Tanggapan',
            ),
            _buildResponse(r),
          ],

          SizedBox(height: r.pad),

          // Riwayat status
          const SectionLabel(icon: Icons.timeline, text: 'Riwayat Status'),
          _buildStep(
            r,
            title: 'Laporan terkirim',
            subtitle: formatDate(report.createdAt),
            done: true,
          ),
          _buildStep(
            r,
            title: 'Ditanggapi petugas',
            subtitle: report.respondedAt != null
                ? formatDate(report.respondedAt!)
                : 'Menunggu tanggapan',
            done: report.isResponded,
            last: true,
          ),
        ],
      ),
    );
  }

  Widget _buildResponse(Responsive r) {
    final responded = report.isResponded;
    final message =
        report.response ??
        (responded
            ? 'Laporan Anda telah ditandai ditanggapi oleh petugas.'
            : 'Laporan Anda sudah terkirim dan sedang menunggu tanggapan '
                  'dari petugas.');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.gap),
      decoration: BoxDecoration(
        color: responded
            ? AppColors.primary.withValues(alpha: 0.06)
            : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(r.radiusS),
        border: Border.all(
          color: responded
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.muted,
          width: r.stroke,
        ),
      ),
      child: Text(
        message,
        style: AppTextStyles.regular(
          r.font(3.8),
          color: responded ? AppColors.textDark : AppColors.textGrey,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildStep(
    Responsive r, {
    required String title,
    required String subtitle,
    required bool done,
    bool last = false,
  }) {
    final color = done ? AppColors.primary : AppColors.muted;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: r.icon,
                height: r.icon,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(
                  done ? Icons.check : Icons.schedule,
                  size: r.font(3.6),
                  color: AppColors.white,
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(width: r.strokeThick, color: color),
                ),
            ],
          ),
          SizedBox(width: r.gap),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : r.gap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bold(r.font(3.8))),
                  Text(
                    subtitle,
                    style: AppTextStyles.regular(
                      r.font(3.4),
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
