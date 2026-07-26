import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/scan_result.dart';

class ScanRepository {
 static const String url ="https://final-project-71fa9-default-rtdb.asia-southeast1.firebasedatabase.app/scan_history.json";

  Future<void> saveScan(ScanResult scan) async {
    await http.post(Uri.parse(url), body: jsonEncode(scan.toJson()));
  }
  Future<List<ScanResult>> getScans() async {
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    List<ScanResult> scans = [];

    if (data == null) {
      return scans;
    }

    for (var item in data.values) {
      ScanResult scan = ScanResult(
        email: item["email"],
        url: item["url"],
        status: item["status"],
      );

      scans.add(scan);
    }
  
    return scans;
  }
  Future<List<ScanResult>> getUserScans(String email) async {
    List<ScanResult> allScans = await getScans();

    List<ScanResult> userScans = [];

    for (var scan in allScans) {
      if (scan.email == email) {
        userScans.add(scan);
      }
    }

    return userScans;
  }

}
