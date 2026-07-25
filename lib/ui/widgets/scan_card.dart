import 'package:flutter/material.dart';

class ScanCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ScanCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFC69B54), size: 40), 
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
