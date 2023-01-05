import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/home_screen/data/models/article_model.dart';

class NewsRepository {
  Future<List<ArticleModel>> getArticles(String categoryName) async {
    List<ArticleModel> articles = [];

    Map<String, String> params = {
      'category': categoryName,
      'country': 'us',
      'apiKey': '22a6860c457f412d9f2e6af023fe07fa',
    };
    // https://newsapi.org/v2/top-headlines?category=$category&apiKey=$apiKey
    final uri = Uri.https('newsapi.org', '/v2/top-headlines', params);

    try {
      final response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> articlesJson = json['articles'];

      articles = articlesJson
          .map((dynamic item) => ArticleModel.fromJson(item))
          .toList();

      return articles;
    } catch (e) {
      throw ("Error on NewsRepository: ${e.toString()}");
    }
  }
}
