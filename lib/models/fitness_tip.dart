class FitnessTip {
  final String title;
  final String body;

  FitnessTip({
    required this.title,
    required this.body,
  });

  factory FitnessTip.fromJson(Map<String, dynamic> json) {
    return FitnessTip(
      title: json['title'] ?? 'Fitness Tip',
      body: json['body'] ?? 'No tip available',
    );
  }
}
