import 'package:flutter/material.dart';

import '../widgets/add_report_fab.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_header.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/menu_card.dart';
import '../widgets/statistics_section.dart';
import '../widgets/welcome_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WelcomeCard(
                      name: 'Luthfi',
                      universityName: 'Konoha University',
                    ),
                    const SizedBox(height: 25),
                    const StatisticsSection(total: 5, sent: 0, responded: 0),
                    const SizedBox(height: 30),
                    MenuCard(
                      icon: Icons.edit_square,
                      title: 'Tulis Laporan Baru',
                      subtitle: 'Sampaikan keluhan dan aspirasi anda',
                      onTap: () => _showMessage('Membuka halaman laporan baru'),
                    ),
                    const SizedBox(height: 20),
                    MenuCard(
                      icon: Icons.format_list_bulleted,
                      title: 'Lihat Laporan Saya',
                      subtitle: 'Pantau status semua laporan anda',
                      onTap: () => _showMessage('Membuka laporan saya'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
      ),
      floatingActionButton: AddReportFab(
        onPressed: () => _showMessage('Tulis laporan baru'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}
