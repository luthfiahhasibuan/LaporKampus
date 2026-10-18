import 'package:flutter/material.dart';

import '../widgets/add_report_fab.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_scaffold.dart';
import 'home_page.dart';
import 'my_report_page.dart';
import '../models/app_routes.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _goToTab(int index) => setState(() => _currentIndex = index);

  Future<void> _openNewReport() async {
    final result = await Navigator.pushNamed(context, AppRoutes.report);
    if (!mounted) return;
    if (result is String) _showMessage('Laporan "$result" terkirim');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(
            onNewReport: _openNewReport,
            onOpenMyReports: () => _goToTab(1),
          ),
          const MyReportPage(),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _goToTab,
      ),
      floatingActionButton: AddReportFab(onPressed: _openNewReport),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
