import 'package:flutter/material.dart';

class ResultRow extends StatelessWidget {
  final String label;
  final String value;
  

  const ResultRow({
    super.key,
    required this.label,
    required this.value,
    
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color:Colors.black, fontSize: 15),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                 
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
