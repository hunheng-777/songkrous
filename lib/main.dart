import 'package:final_project/ui/screens/home_screen.dart';
import 'package:final_project/ui/screens/url_scan_screen.dart';
import 'package:flutter/material.dart';
import 'ui/screens/result_danger_screen.dart';
import 'ui/screens/result_safe_screen.dart';
import 'ui/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
