import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/common/constants/url_constant.dart';
import 'package:news_app/data/models/news_article_model.dart';

class NewsRepository {
  Future<List<ArticleModel>> getArticles(String categoryName) async {
    List<ArticleModel> articles = [];

    Map<String, String> params = {
      'category': categoryName,
      'country': 'us',
      'apiKey': '22a6860c457f412d9f2e6af023fe07fa',
    };

    Dio dio = Dio();

    try {
      final response = await dio.get(baseUrl, queryParameters: params);
      Map<String, dynamic> json = jsonDecode(response.data);
      List<dynamic> articlesJson = json['articles'];

      articles = articlesJson
          .map((dynamic item) => ArticleModel.fromJson(item))
          .toList();

      return articles;
    } catch (e) {
      if (kDebugMode) print("Error on NewsRepository: ${e.toString()}");
    }

    return [];
  }
}