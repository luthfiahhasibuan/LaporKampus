import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/app_header.dart';
import '../widgets/app_scaffold.dart';
import '../models/report_data.dart';
import '../providers/report_provider.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _picker = ImagePicker();

  static const Map<String, IconData> _categories = {
    'Fasilitas': Icons.apartment_outlined,
    'Akademik': Icons.school_outlined,
    'Kebersihan': Icons.cleaning_services_outlined,
    'Keamanan': Icons.shield_outlined,
    'Lainnya': Icons.more_horiz,
  };

  static const List<String> _allowedExtensions = ['jpg', 'jpeg', 'png'];
  static const int _maxImageBytes = 5 * 1024 * 1024; // 5 MB

  String _selectedCategory = 'Lainnya';
  XFile? _image;
  Uint8List? _imageBytes;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showMessage(String text, {Color? color}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  void _showPickerSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari galeri'),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(ImageSource.gallery);
              },
            ),
            // Kamera tidak tersedia di Flutter Web
            if (!kIsWeb)
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Ambil foto'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.camera);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 85);
    if (file == null) return; //batal

    final extension = file.name.split('.').last.toLowerCase();
    final bytes = await file.readAsBytes();
    if (!mounted) return;

    if (!_allowedExtensions.contains(extension)) {
      _showMessage('Format foto harus JPG atau PNG');
      return;
    }
    if (bytes.length > _maxImageBytes) {
      _showMessage('Ukuran foto maksimal 5MB');
      return;
    }

    setState(() {
      _image = file;
      _imageBytes = bytes;
    });
  }

  void _removeImage() {
    setState(() {
      _image = null;
      _imageBytes = null;
    });
  }

  String _formatSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1024).round()} KB';
  }

  void _resetForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedCategory = 'Lainnya';
      _image = null;
      _imageBytes = null;
    });
  }

  void _submitReport() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    // Validasi formulir.
    if (title.isEmpty || description.isEmpty) {
      _showMessage('Judul dan isi laporan wajib diisi!');
      return;
    }

    context.read<ReportProvider>().addReport(
      ReportData(
        title: title,
        category: _selectedCategory,
        description: description,
        imagePath: _image?.path,
      ),
    );

    _showMessage('Laporan berhasil dikirim!', color: Colors.green);
    _resetForm();

    Navigator.pop(context);
  }

  // Dekorasi yang sama untuk semua input di form ini
  InputDecoration _inputDecoration(
    Responsive r, {
    String? hint,
    IconData? icon,
  }) {
    OutlineInputBorder border(Color color, double width) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(r.radiusS),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.regular(r.font(3.6), color: AppColors.textGrey),
      prefixIcon: icon == null ? null : Icon(icon),
      prefixIconColor: AppColors.primary,
      filled: true,
      fillColor: AppColors.primary.withValues(alpha: 0.04),
      contentPadding: EdgeInsets.all(r.gap),
      enabledBorder: border(AppColors.border, r.stroke),
      focusedBorder: border(AppColors.primary, r.strokeThick),
    );
  }

  Widget _label(Responsive r, IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.gapS),
      child: Row(
        children: [
          Icon(icon, size: r.gap, color: AppColors.primary),
          SizedBox(width: r.gapS),
          Text(text, style: AppTextStyles.bold(r.font(3.8))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;

    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(r.pad, r.pad, r.pad, r.bottom),
                // Batasi lebar kartu & tengahkan di layar lebar
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: r.maxWidth),
                    child: Container(
                      clipBehavior:
                          Clip.antiAlias, // header hijau ikut melengkung
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(r.radius),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: r.gap,
                            offset: Offset(0, r.gapS),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildCardHeader(r), _buildForm(r)],
                      ),
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

  Widget _buildCardHeader(Responsive r) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: r.pad, vertical: r.gap),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryLight, AppColors.primary],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(r.gapS),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.edit_square,
              color: AppColors.white,
              size: r.icon,
            ),
          ),
          SizedBox(width: r.gap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tulis Laporan Baru',
                  style: AppTextStyles.bold(
                    r.font(4.6),
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Sampaikan masalah dengan jelas agar cepat ditangani.',
                  style: AppTextStyles.regular(r.font(4))
                      .copyWith(color: AppColors.white.withValues(alpha: 0.85)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(Responsive r) {
    return Padding(
      padding: EdgeInsets.all(r.pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lokasi
          _label(r, Icons.place_outlined, 'Lokasi Laporan'),
          TextField(
            controller: _titleController,
            style: AppTextStyles.regular(r.font(4)),
            keyboardType: TextInputType.text,
            decoration: _inputDecoration(
              r,
              hint: 'Isi Lokasi kerusakan',
              icon: Icons.location_on_outlined,
            ),
          ),

          SizedBox(height: r.pad),

          // Kategori
          _label(r, Icons.category_outlined, 'Kategori'),
          _buildCategoryChips(r),

          SizedBox(height: r.pad),

          // Isi laporan
          _label(r, Icons.notes_outlined, 'Isi Laporan'),
          TextField(
            controller: _descriptionController,
            style: AppTextStyles.regular(r.font(4)),
            keyboardType: TextInputType.multiline,
            minLines: r.lines,
            maxLines: r.lines,
            decoration: _inputDecoration(
              r,
              hint: 'Jelaskan laporan Anda secara detail...',
            ),
          ),

          SizedBox(height: r.pad),

          // Lampiran foto
          _label(r, Icons.image_outlined, 'Lampiran Foto'),
          _buildPhotoPicker(r),

          SizedBox(height: r.pad),

          _buildButtons(r),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(Responsive r) {
    return Wrap(
      spacing: r.gapS,
      runSpacing: r.gapS,
      children: [
        for (final entry in _categories.entries)
          _buildCategoryChip(r, entry.key, entry.value),
      ],
    );
  }

  Widget _buildCategoryChip(Responsive r, String name, IconData icon) {
    final selected = _selectedCategory == name;
    final color = selected ? AppColors.white : AppColors.primary;

    return ChoiceChip(
      avatar: Icon(icon, size: r.gap, color: color),
      label: Text(
        name,
        style: AppTextStyles.regular(r.font(4))
            .copyWith(color: selected ? AppColors.white : null),
      ),
      selected: selected,
      showCheckmark: false,
      backgroundColor: AppColors.white,
      selectedColor: AppColors.primary,
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
          width: r.stroke,
        ),
      ),
      onSelected: (_) => setState(() => _selectedCategory = name),
    );
  }

  Widget _buildPhotoPicker(Responsive r) {
    final bytes = _imageBytes;

    // Belum ada foto: area ketuk untuk memilih
    if (bytes == null) {
      return InkWell(
        borderRadius: BorderRadius.circular(r.radiusS),
        onTap: _showPickerSheet,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(r.pad),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(r.radiusS),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.4),
              width: r.stroke,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                size: r.icon,
                color: AppColors.primary,
              ),
              SizedBox(height: r.gapS),
              Text(
                'Ketuk untuk memilih foto',
                style: AppTextStyles.bold(r.font(3.8)),
              ),
              SizedBox(height: r.gapS),
              Text(
                'Format: JPG/PNG. Maks. 5MB',
                style: AppTextStyles.regular(
                  r.font(3.6),
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Sudah ada foto: tampilkan pratinjau
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(r.radiusS),
              child: Image.memory(
                bytes,
                width: double.infinity,
                height: r.sp(50),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: r.gapS,
              right: r.gapS,
              child: Row(
                children: [
                  _photoAction(Icons.edit_outlined, _showPickerSheet),
                  SizedBox(width: r.gapS),
                  _photoAction(Icons.delete_outline, _removeImage),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: r.gapS),
        Text(
          '${_image!.name} · ${_formatSize(bytes.length)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.regular(r.font(3.6), color: AppColors.textGrey),
        ),
      ],
    );
  }

  Widget _photoAction(IconData icon, VoidCallback onPressed) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      visualDensity: VisualDensity.compact,
      style: IconButton.styleFrom(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildButtons(Responsive r) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: _submitReport,
            icon: Icon(Icons.send, size: r.gap),
            label: const Text('Kirim'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              minimumSize: Size.fromHeight(r.button),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(r.radiusS),
              ),
            ),
          ),
        ),
        SizedBox(width: r.gap),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: Size.fromHeight(r.button),
              side: BorderSide(color: AppColors.primary, width: r.strokeThick),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(r.radiusS),
              ),
            ),
            child: const Text('Batal'),
          ),
        ),
      ],
    );
  }
}
