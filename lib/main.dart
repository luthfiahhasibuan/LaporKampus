import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_routes.dart';
import 'providers/report_provider.dart';
import 'utils/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LaporKampusApp());
}

class LaporKampusApp extends StatelessWidget {
  const LaporKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lapor Kampus',
        theme: AppTheme.light,
        initialRoute: AppRoutes.initial,
        routes: AppRoutes.routes,
      ),
    );
  }
}
