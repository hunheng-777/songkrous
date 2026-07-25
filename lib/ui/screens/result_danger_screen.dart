import 'package:flutter/material.dart';
import '../widgets/result_row.dart';

class ResultDangerScreen extends StatelessWidget {
  const ResultDangerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E2D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E2D6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            decoration: const BoxDecoration(color: Color(0xFFB23B3B)),
            child: Column(
              children: const [
                Icon(Icons.cancel, color: Colors.white, size: 80),
                SizedBox(height: 16),
                Text(
                  "Dangerous Link",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "This URL is unsafe. Do not visit.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          
           Column(
              children: const [
                ResultRow(label: "Status", value: "Dangerous"),
                ResultRow(label: "Threat Type", value: "Phishing"),
                ResultRow(label: "Detections", value: "15/90 Vendors"),
                ResultRow(label: "Scanned", value: "26 Jun 2026"),
              ],
            
          ),
        ],
      ),
    );
  }
}
