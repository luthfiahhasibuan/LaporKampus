import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const LaporKampusApp());
}

class LaporKampusApp extends StatelessWidget {
  const LaporKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lapor Pak Rektor',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF455B8A)),
      ),

      home: const HomePage(),
    );
  }
}
