import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = 'YOUR_API_KEY';
  final String baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse('$baseUrl?country=us&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
