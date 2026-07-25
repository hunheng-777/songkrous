import 'dart:convert';
import 'package:http/http.dart' as http;

class UrlCheckService {
  static const String apiKey = "AIzaSyCoICtT2rBCl6jh7sLxpXyhPJUVkilyuu4";

  static const String endpoint =
      "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=$apiKey";

  Future<bool> checkUrl(String url) async {
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

    return result["matches"] == null;
  }
}
