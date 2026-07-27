import 'package:final_project/data/repositories/auth_repository.dart';
import 'package:final_project/data/repositories/scan_repository.dart';
import 'package:final_project/models/safe_browsing_response.dart';
import 'package:final_project/models/scan_result.dart';
import 'package:flutter/material.dart';

import '../widgets/recent_item.dart';
import 'result_safe_screen.dart';
import 'result_danger_screen.dart';
import '../../services/url_check_service.dart';
import '../../models/scan_result.dart';
import '../../data/repositories/scan_repository.dart';
class UrlScanScreen extends StatefulWidget {
  const UrlScanScreen({super.key});

  @override
  State<UrlScanScreen> createState() => _UrlScanScreenState();
}

class _UrlScanScreenState extends State<UrlScanScreen> {
  TextEditingController urlController = TextEditingController();

  List<ScanResult> scans = [];

  String errorMessage = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    loadScans();
  }
  Future<void> loadScans() async {
    ScanRepository repository = ScanRepository();

    List<ScanResult> data = await repository.getUserScans(
      AuthRepository.currentUser!.email,
    );

    setState(() {
      scans = data;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    Widget historyWidget;
    if (scans.isEmpty) {
  historyWidget = Center(
    child: Text("No Scan History"),
  );
} else {
  historyWidget = ListView.builder(
    itemCount: scans.length,
    itemBuilder: (context, index) {
      return RecentItem(
        url: scans[index].url,
        status: scans[index].status,
        statusColor: scans[index].status == "Safe"
            ? Colors.green
            : Colors.red,
      );
    },
  );
}
    return Scaffold(
      backgroundColor: const Color(0xFFECE4D8),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            SizedBox(height:25),
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

                       SafeBrowsingResponse response = await service.checkUrl(
                          urlController.text,
                        );
                        ScanRepository repository = ScanRepository();

                        await repository.saveScan(
                          ScanResult(
                            email: AuthRepository.currentUser!.email,
                            url: urlController.text,
                            status: response.isThreat ? "Danger" : "Safe",
                          ),
                        );
                        await loadScans();
                        setState(() {
                          isLoading = false;
                        });

                        if (response.isThreat) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultDangerScreen(threatTypes: response.threatTypes,),
                            ),
                          );
                          
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResultSafeScreen(),
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
            Expanded(
              child: historyWidget
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
