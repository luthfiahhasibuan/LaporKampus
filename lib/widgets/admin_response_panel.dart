import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/report_data.dart';
import '../providers/report_provider.dart';
import '../utils/app_theme.dart';
import '../utils/input_decoration.dart';
import '../utils/responsive.dart';
import 'section_label.dart';

class AdminResponsePanel extends StatefulWidget {
  const AdminResponsePanel({super.key, required this.report});

  final ReportData report;

  @override
  State<AdminResponsePanel> createState() => _AdminResponsePanelState();
}

class _AdminResponsePanelState extends State<AdminResponsePanel> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.report.response,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(seconds: 1)),
    );
  }

  void _changeStatus(String status) {
    context.read<ReportProvider>().updateStatus(widget.report, status);
    // Kembali ke Terkirim menghapus tanggapan, kolomnya ikut dikosongkan.
    if (status == ReportStatus.sent) _controller.clear();
  }

  void _sendResponse() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      _showMessage('Tanggapan tidak boleh kosong');
      return;
    }
    context.read<ReportProvider>().respond(widget.report, text);
    _showMessage('Tanggapan berhasil dikirim');
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final report = widget.report;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(icon: Icons.flag_outlined, text: 'Ubah Status'),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<String>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: ReportStatus.sent,
                label: Text(ReportStatus.sent),
              ),
              ButtonSegment(
                value: ReportStatus.responded,
                label: Text(ReportStatus.responded),
              ),
            ],
            selected: {report.status},
            onSelectionChanged: (selection) => _changeStatus(selection.first),
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: AppColors.primary,
              selectedForegroundColor: AppColors.white,
              foregroundColor: AppColors.textGrey,
              textStyle: AppTextStyles.semibold(r.font(3.6)),
            ),
          ),
        ),

        SizedBox(height: r.pad),

        const SectionLabel(
          icon: Icons.question_answer_outlined,
          text: 'Tanggapan Admin',
        ),
        TextField(
          controller: _controller,
          style: AppTextStyles.regular(r.font(4)),
          keyboardType: TextInputType.multiline,
          minLines: r.lines ~/ 2,
          maxLines: r.lines ~/ 2,
          decoration: appInputDecoration(
            r,
            hint: 'Tulis tanggapan untuk pelapor...',
          ),
        ),

        SizedBox(height: r.gap),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _sendResponse,
            icon: Icon(Icons.send, size: r.gap),
            label: Text(
              report.isResponded ? 'Perbarui Tanggapan' : 'Kirim Tanggapan',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              minimumSize: Size.fromHeight(r.button),
              textStyle: AppTextStyles.semibold(r.font(3.8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(r.radiusS),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
