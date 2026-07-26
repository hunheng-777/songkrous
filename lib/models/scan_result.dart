class ScanResult {
  String email;
  String url;
  String status;

  ScanResult({required this.email, required this.url, required this.status});

  static ScanResult fromJson(Map<String, dynamic> json) {
    return ScanResult(
      email: json["email"],
      url: json["url"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "url": url, "status": status};
  }
}
