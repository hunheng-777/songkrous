import 'package:final_project/data/repositories/auth_repository.dart';
import 'package:final_project/data/repositories/scan_repository.dart';
import 'package:final_project/models/safe_browsing_response.dart';
import 'package:final_project/models/scan_result.dart';
import 'package:final_project/ui/screens/result_danger_screen.dart';
import 'package:final_project/ui/screens/result_safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../services/url_check_service.dart';
import '../../services/qr_service.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool isChecking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        // foregroundColor: Colors.white,
        title: const Text("Scan QR Code"),
      ),
      body: MobileScanner(
        onDetect: (capture) async {
          if (isChecking) return;

          final String link = capture.barcodes.first.rawValue ?? "";
          if (link.isEmpty) return;

          setState(() => isChecking = true);

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
              MaterialPageRoute(builder: (context) => const ResultSafeScreen()),
            );
          }
        },
      ),
    );
  }
}
