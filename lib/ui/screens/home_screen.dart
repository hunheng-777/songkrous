import 'package:final_project/data/repositories/auth_repository.dart';
import 'package:final_project/data/repositories/scan_repository.dart';
import 'package:final_project/models/scan_result.dart';
import 'package:final_project/ui/screens/qr_scan_screen.dart';
import 'package:final_project/ui/screens/url_scan_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/scan_card.dart';
import '../widgets/recent_item.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ScanResult> scans = [];
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
      historyWidget = Center(child: Text("No Scan History"));
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
      backgroundColor: const Color(0xFFE9E2D6), 
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    SizedBox(height: 25,),
                    Text(
                      "Hello, ${AuthRepository.currentUser!.name}",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Stay safe every day!",
                      style: TextStyle(color: Color(0xFF8A8375)),
                    ),
                  ],
                ),

                
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Color(0xFFC69B54),
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            
            Row(
              children:  [

              ScanCard(
                  title: "URL Scanner",
                  icon: Icons.link,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UrlScanScreen(),
                      ),
                    ).then((_) {
                      loadScans();
                    });
                  },
                ),
                SizedBox(width: 16),
                ScanCard(
                  title: "Qr Scanner",
                  icon: Icons.link,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QrScanScreen(),
                      ),
                    ).then((_) {
                      loadScans();
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            
            const Text(
              "Recent Scans",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

          
           Expanded(
              child: historyWidget
            )

          ],
        ),
      ),
    );
  }
}
