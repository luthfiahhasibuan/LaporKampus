import 'package:flutter/material.dart';

// import '../pages/home_page.dart';
import '../pages/main_shell.dart';
// import '../pages/my_report_page.dart';
import '../pages/profile_page.dart';
import '../pages/report_page.dart';
import '../pages/signin_page.dart';
import '../pages/signup_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String main = '/main'; // MainShell (bottom navigation)
  // static const String home = '/home';
  static const String report = '/report';
  // static const String myReport = '/my-report';
  static const String profile = '/profile';

  static const String initial = signIn; //halaman pertama

  static final Map<String, WidgetBuilder> routes = {
    signIn: (_) => const SignInPage(),
    signUp: (_) => const SignUpPage(),
    main: (_) => const MainShell(),
    // home: (_) => const HomePage(),
    report: (_) => const ReportPage(),

    // myReport: (_) => const MyReportPage(),
    profile: (_) => const ProfilePage(),
  };
}
