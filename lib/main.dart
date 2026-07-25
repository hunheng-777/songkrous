import 'package:flutter/material.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/signup_screen.dart';
import 'ui/screens/url_scan_screen.dart';

void main() {
  runApp(const SongKrousApp());
}

class SongKrousApp extends StatelessWidget {
  const SongKrousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SongKrous',
      home: const UrlScanScreen(),
    );
  }
}
