import 'package:flutter/material.dart';

import '../widgets/recent_item.dart';
import 'result_safe_screen.dart';
import 'result_danger_screen.dart';
import '../../services/url_check_service.dart';

class UrlScanScreen extends StatefulWidget {
  const UrlScanScreen({super.key});

  @override
  State<UrlScanScreen> createState() => _UrlScanScreenState();
}

class _UrlScanScreenState extends State<UrlScanScreen> {
  TextEditingController urlController = TextEditingController();

  List<Map<String, String>> recentScans = [
    {"url": "https://google.com", "status": "Safe", "time": "2m ago"},
    {"url": "http://free-money.xyz", "status": "Danger", "time": "10m ago"},
    {"url": "https://cadt.edu.kh", "status": "Safe", "time": "25m ago"},
  ];

  String errorMessage = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE4D8),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),

            SizedBox(height: 10),

            
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "URL Scanner",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Enter or paste the URL below",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

           
            TextField(
              controller: urlController,

              decoration: InputDecoration(
                hintText: "https://example.com",

               

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),

                      onPressed: () async {
                        if (urlController.text.isEmpty) {
                          setState(() {
                            errorMessage = "Please enter a URL";
                          });

                          return;
                        }

                        setState(() {
                          errorMessage = "";
                          isLoading = true;
                        });

                        UrlCheckService service = UrlCheckService();

                        bool isSafe = await service.checkUrl(
                          urlController.text.trim(),
                        );

                        setState(() {
                          isLoading = false;
                        });

                        if (isSafe) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResultSafeScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResultDangerScreen(),
                            ),
                          );
                        }
                      },

                      child: Text(
                        "Scan URL",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (isLoading)
              const Text(
                "Checking URL...",
                style: TextStyle(color: Colors.red),
              ),

            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            SizedBox(height: 30),

            
            Row(
              children: [
                Text(
                  "Recent Scans",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 10),
            const RecentItem(
              url: "https://google.com",
              status: "Safe",
              statusColor: Color.fromARGB(255, 83, 223, 118),
            ),
            const RecentItem(
              url: "http://free-money.xyz",
              status: "Danger",
              statusColor: Color(0xFFB23B3B),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: allScans.length > 4 ? 4 : allScans.length, // max 4
            //     itemBuilder: (context, index) {
            //       final scan = allScans[index];
            //       return RecentItem(
            //         url: scan["url"],
            //         status: scan["status"],
            //         statusColor: scan["color"],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
