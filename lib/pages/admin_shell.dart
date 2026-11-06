import 'package:flutter/material.dart';

import '../widgets/app_bottom_navigation.dart';
import '../widgets/app_scaffold.dart';
import 'admin_dashboard_page.dart';
import 'my_report_page.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  static const List<AppNavItem> _navItems = [
    AppNavItem(icon: Icons.dashboard, label: 'Dashboard'),
    AppNavItem(icon: Icons.description, label: 'Laporan'),
  ];

  int _currentIndex = 0;

  void _goToTab(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          AdminDashboardPage(onOpenReports: () => _goToTab(1)),
          const MyReportPage(isAdmin: true),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _goToTab,
        items: _navItems,
        reserveFabSpace: false, // admin tidak punya tombol tambah laporan
      ),
    );
  }
}
