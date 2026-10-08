import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/add_report_fab.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_header.dart';
import '../widgets/app_scaffold.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  static const List<String> _categories = [
    'Fasilitas',
    'Akademik',
    'Kebersihan',
    'Keamanan',
    'Lainnya',
  ];

  String _selectedCategory = 'Lainnya';
  String? _selectedFileName;
  int _selectedNavIndex = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Dekorasi yang sama untuk semua input di form ini
  InputDecoration _inputDecoration({String? hint}) {
    OutlineInputBorder border(Color color, double width) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.formHint,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: border(AppColors.border, 1),
      focusedBorder: border(AppColors.primary, 2),
    );
  }

  void _resetForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedCategory = 'Lainnya';
      _selectedFileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Container(
                  clipBehavior: Clip.antiAlias, // header hijau ikut melengkung
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HEADER KARTU
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        color: AppColors.primary,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit_square,
                              color: AppColors.white,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Tulis Laporan Baru',
                              style: AppTextStyles.reportTitle,
                            ),
                          ],
                        ),
                      ),

                      // ISI FORM
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Judul
                            const Text(
                              'Judul Laporan',
                              style: AppTextStyles.formLabel,
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _titleController,
                              style: AppTextStyles.formInput,
                              keyboardType: TextInputType.text,
                              decoration: _inputDecoration(
                                hint: 'Jenis Kerusakan yang ingin dilaporkan',
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Kategori
                            const Text(
                              'Kategori',
                              style: AppTextStyles.formLabel,
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              initialValue: _selectedCategory,
                              style: AppTextStyles.formInput,
                              dropdownColor: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              decoration: _inputDecoration(),
                              items: _categories
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _selectedCategory = value);
                              },
                            ),

                            const SizedBox(height: 20),

                            // Isi laporan
                            const Text(
                              'Isi Laporan',
                              style: AppTextStyles.formLabel,
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _descriptionController,
                              style: AppTextStyles.formInput,
                              keyboardType: TextInputType.multiline,
                              minLines: 6,
                              maxLines: 6,
                              decoration: _inputDecoration(
                                hint: 'Jelaskan laporan Anda secara detail...',
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Lampiran foto
                            const Text(
                              'Lampiran Foto',
                              style: AppTextStyles.formLabel,
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                // TODO: buka pemilih file (package file_picker / image_picker)
                                // lalu simpan nama file ke _selectedFileName
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE9E9E9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'Choose File',
                                        style: AppTextStyles.formInput,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _selectedFileName ?? 'No File Chosen',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.formHint,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),
                            const Text(
                              'Format: JPG/PNG. Maks. 5MB',
                              style: AppTextStyles.formHint,
                            ),

                            const SizedBox(height: 24),

                            // Tombol
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // TODO: validasi lalu kirim laporan
                                    },
                                    icon: const Icon(Icons.send, size: 18),
                                    label: const Text('Kirim'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      minimumSize: const Size.fromHeight(46),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _resetForm,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      minimumSize: const Size.fromHeight(46),
                                      side: const BorderSide(
                                        color: AppColors.primary,
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text('Batal'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      floatingActionButton: AddReportFab(
        onPressed: () {
          // Sudah di halaman tulis laporan; bisa dipakai untuk fokus ke form
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
