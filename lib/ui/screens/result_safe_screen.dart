import 'package:flutter/material.dart';

class ResultSafeScreen extends StatelessWidget {
  const ResultSafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E2D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E2D6),
        
        iconTheme: const IconThemeData(color: Colors.black),
        
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            decoration: const BoxDecoration(
              color: Color(0xFF5B8C6E),
          
            ),
            child: Column(
              children: const [
                Icon(Icons.check_circle, color: Colors.white, size: 80),
                SizedBox(height: 16),
                Text(
                  "Safe Link",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "This URL appears to be safe.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                _detailRow("Status", "Safe", const Color(0xFF5B8C6E)),
                _detailRow("Protocol", "HTTPS", Colors.black87),
                _detailRow("Domain", "google.com", Colors.black87),
                _detailRow("Scanned", "26 Jun 2026", Colors.black87),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color(0xFF8A8375), fontSize: 15),
              ),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFC9C0B0)),
        ],
      ),
    );
  }
}
