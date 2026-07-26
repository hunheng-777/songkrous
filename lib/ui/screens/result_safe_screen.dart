import 'package:flutter/material.dart';
import '../widgets/result_row.dart';

class ResultSafeScreen extends StatelessWidget {
  const ResultSafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E2D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E2D6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            decoration: const BoxDecoration(color:Colors.green),
            child: Column(
              children: const [
                Icon(Icons.check, color: Colors.white, size: 80),
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
                  "This URL is safe.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

         
            Column(
              children: const [
                ResultRow(label: "Status", value: "Safe"),
            
              ],
            ),
          
        ],
      ),
    );
  }
}
