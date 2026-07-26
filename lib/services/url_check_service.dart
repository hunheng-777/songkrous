import 'dart:convert';
import 'package:final_project/models/safe_browsing_response.dart';
import 'package:http/http.dart' as http;

class UrlCheckService {
  static const String apiKey = "AIzaSyCoICtT2rBCl6jh7sLxpXyhPJUVkilyuu4";

  static const String endpoint =
      "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey";

  Future<SafeBrowsingResponse> checkUrl(String url) async {
    final response = await http.post(
      Uri.parse(endpoint),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode({
        "client": {"clientId": "songkrous", "clientVersion": "1.0"},

        "threatInfo": {
          "threatTypes": [
            "MALWARE",
            "SOCIAL_ENGINEERING",
            "UNWANTED_SOFTWARE",
            "POTENTIALLY_HARMFUL_APPLICATION",
          ],

          "platformTypes": ["ANY_PLATFORM"],

          "threatEntryTypes": ["URL"],

          "threatEntries": [
            {"url": url},
          ],
        },
      }),
    );

    Map<String, dynamic> result = jsonDecode(response.body);
    List<String> threatTypes = [];
    if (result["matches"] != null) {
      for (var match in result["matches"]) {
        threatTypes.add(match["threatType"]);
      }
    }
    return SafeBrowsingResponse(
      isThreat: result["matches"] != null,
      threatTypes: threatTypes,
    );
  }
}
