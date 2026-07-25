import 'package:flutter/material.dart';

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

                      onPressed: () {},

                      child: Text(
                        "Scan URL",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),

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
              child: ListView.builder(
                itemCount: recentScans.length,

                itemBuilder: (context, index) {
                  

                  return Card(
                    margin: EdgeInsets.only(bottom: 10),

                    child: ListTile(
                      leading: Icon(
                        recentScans[index]["status"] == "Safe" ? Icons.check_circle : Icons.error,

                        color: recentScans[index]["status"] == "Safe" ? Colors.orange : Colors.red,
                      ),

                      title: Text(recentScans[index]["url"]!),

                      subtitle: Text(
                        "${recentScans[index]["status"]} • ${recentScans[index]["time"]}",
                      ),

                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
