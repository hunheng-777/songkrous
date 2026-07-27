import 'package:final_project/data/repositories/auth_repository.dart';
import 'package:final_project/data/repositories/scan_repository.dart';
import 'package:final_project/models/safe_browsing_response.dart';
import 'package:final_project/models/scan_result.dart';
import 'package:final_project/ui/screens/result_danger_screen.dart';
import 'package:final_project/ui/screens/result_safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/url_check_service.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool isChecking = false;
  bool noInternet = false;

  @override
  Widget build(BuildContext context) {
    
    if (noInternet) {
      return Scaffold(
        backgroundColor: const Color(0xFFECE4D8),

        appBar: AppBar(
          backgroundColor: const Color(0xFF1C1C1C),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80, color: Color(0xFFB23B3B)),
              SizedBox(height: 20),
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        title: const Text("Scan QR Code"),
      ),

      body: MobileScanner(
        onDetect: (capture) async {
          if (isChecking) return;

          final String link = capture.barcodes.first.rawValue ?? "";
          if (link.isEmpty) return;

          setState(() => isChecking = true);

          try {
            final service = UrlCheckService();

            SafeBrowsingResponse response = await service.checkUrl(link);

            ScanRepository repository = ScanRepository();

            await repository.saveScan(
              ScanResult(
                email: AuthRepository.currentUser!.email,
                url: link,
                status: response.isThreat ? "Danger" : "Safe",
              ),
            );

            if (!mounted) return;

            if (response.isThreat) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ResultDangerScreen(threatTypes: response.threatTypes),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResultSafeScreen(),
                ),
              );
            }
          } catch (e) {
            if (!mounted) return;

            setState(() {
              noInternet = true;
            });
          }
        },
      ),
    );
  }
}
