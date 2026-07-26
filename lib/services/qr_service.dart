import 'package:final_project/services/url_check_service.dart';

class QrService {
  final UrlCheckService _urlCheckService = UrlCheckService();

  Future<Object> checkQrLink(String rawValue) async {
    final link = rawValue.trim();

    if (link.isEmpty || !link.startsWith("http")) {
      return false;
    }

    return await _urlCheckService.checkUrl(link);
  }
}
