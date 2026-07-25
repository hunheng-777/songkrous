import 'package:final_project/ui/screens/url_scan_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/scan_card.dart';
import '../widgets/recent_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E2D6), 
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Greeting
            const Text(
              "Hello, Rain",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Stay safe every day!",
              style: TextStyle(color: Color(0xFF8A8375)), 
            ),
          //  IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const UrlScanScreen(),
          //         ),
          //       );
          //     },
          //     icon: const Icon(
          //       Icons.person,
          //       color: Color(0xFFC69B54),
          //       size: 30,
          //     ),
          //   ),


            const SizedBox(height: 30),

            
            Row(
              children:  [

                ScanCard(title: "URL Scanner", icon: Icons.link,screen:UrlScanScreen()),
                SizedBox(width: 16),
                ScanCard(title: "QR Scanner", icon: Icons.qr_code_scanner,screen:UrlScanScreen()),
              ],
            ),

            const SizedBox(height: 30),

            
            const Text(
              "Recent Scans",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

          
            const RecentItem(
              url: "https://google.com",
              status: "Safe",
              statusColor: Color(0xFF5B8C6E), 
            ),
            const RecentItem(
              url: "http://free-money.xyz",
              status: "Danger",
              statusColor: Color(0xFFB23B3B), 
            ),
          ],
        ),
      ),
    );
  }
}
