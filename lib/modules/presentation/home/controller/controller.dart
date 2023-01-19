import 'package:get/get.dart';
import 'package:news_app/data/data_source/remote_data_source/news_repo.dart';
import 'package:news_app/data/models/news_article_model.dart';

enum HomeScreenState { initial, loading, error, loaded }

class HomeScreenController extends GetxController {
  static final HomeScreenController to = Get.find();

  String _categoryName = 'general';
  String get categoryName => _categoryName;

  HomeScreenState _homeScreenState = HomeScreenState.initial;
  HomeScreenState get homeScreenState => _homeScreenState;

  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  // For fetching
  late List<ArticleModel> _allArticles; //stores complete article list
  List<ArticleModel> _searchItems = [];

  // for lazy loading
  int top = 0;
  int limit = 5;
  bool hasMore = true;

  _reset() {
    top = 0;
    hasMore = true;
  }

  Future getArticles({String? categoryName}) async {
    _categoryName = categoryName ?? _categoryName;
    _reset();
    // set state to loading
    _homeScreenState = HomeScreenState.loading;
    update();

    _allArticles = await NewsRepository.to.getArticles(_categoryName);
    // set search items
    _searchItems.clear();
    _searchItems.addAll(_allArticles);

    // On successfully loading news, start lazy loading
    lazyLoadArticles();
  }

  Future lazyLoadArticles() async {
    if (hasMore) {
      // Wait 1.2sec before load
      await Future.delayed(const Duration(milliseconds: 1200));

      top += limit;
      // if articles are less than start
      if (_allArticles.length < top) {
        _articles = _allArticles;
      } else {
        _articles = _allArticles.getRange(0, top).toList();
      }

      if (top >= _allArticles.length) hasMore = false;
    }

    _homeScreenState = HomeScreenState.loaded;
    update();
  }

  Future searchArticles({String searchText = ''}) async {
    _reset();

    List<ArticleModel> dummySearchList = [];
    dummySearchList.addAll(_searchItems);

    String query = searchText.toLowerCase();

    if (query.isNotEmpty) {
      List<ArticleModel> dummyListData = [];
      for (ArticleModel item in dummySearchList) {
        if (item.title!.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      _allArticles.clear();
      _allArticles.addAll(dummyListData);
    } else {
      _allArticles.clear();
      _allArticles.addAll(_searchItems);
    }

    // On successfully loading news, start lazy loading
    lazyLoadArticles();
  }
}
