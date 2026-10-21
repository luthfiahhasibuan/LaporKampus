import 'package:flutter/material.dart';

import 'models/app_routes.dart';

import 'package:provider/provider.dart';

import '../providers/report_provider.dart';

void main() => runApp(const LaporKampusApp());

class LaporKampusApp extends StatelessWidget {
  const LaporKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lapor Kampus',
        initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      ),
    );
  }
}
