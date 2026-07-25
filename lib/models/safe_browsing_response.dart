class SafeBrowsingResponse {
  final bool isThreat;
  final List<String> threatTypes;

  SafeBrowsingResponse({required this.isThreat, required this.threatTypes});
}
