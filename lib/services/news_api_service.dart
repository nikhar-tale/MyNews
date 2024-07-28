import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news/models/news_article.dart';

class NewsApiService {
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchNews(String countryCode, String apiKey) async {
    String url = '$_baseUrl/top-headlines?country=$countryCode&apiKey=$apiKey';
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final articles = jsonResponse['articles'] as List;
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
