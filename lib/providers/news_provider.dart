import 'package:flutter/material.dart';
import 'package:my_news/models/news_article.dart';
import 'package:my_news/services/news_api_service.dart';
import 'package:my_news/services/remote_config_service.dart';

class NewsProvider with ChangeNotifier {
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';
  final RemoteConfigService _remoteConfigService;

  NewsProvider(this._remoteConfigService) {
    fetchNews();
  }

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      final countryCode = _remoteConfigService.countryCode;
      final apiKey = _remoteConfigService.apiKey;
      _articles = await NewsApiService().fetchNews(countryCode, apiKey);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
