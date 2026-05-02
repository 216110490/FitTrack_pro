import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/fitness_tip.dart';

class ApiService {
  static Future<FitnessTip> fetchFitnessTip() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return FitnessTip.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Could not load fitness tip');
    }
  }
}
