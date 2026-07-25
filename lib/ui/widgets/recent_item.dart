import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final String url;
  final String status;
  final Color statusColor;

  const RecentItem({
    super.key,
    required this.url,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: statusColor, size: 14),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              url,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
