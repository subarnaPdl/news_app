import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';
import 'package:news_app/home_screen/data/repo/news_repo.dart';

import '../bloc/news_event.dart';
import '../bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  late List<ArticleModel> allArticles; //stores complete article list
  List<ArticleModel> articles = [];
  List<ArticleModel> searchItems = [];
  String categoryName = 'general';

  // for lazy loading
  int top = 0;
  int limit = 5;
  bool hasMore = true;

  reset() {
    top = 0;
    hasMore = true;
  }

  NewsBloc() : super(NewsInitialState()) {
    on<NewsEvent>((event, emit) async {
      // Get Articles
      if (event is GetArticlesEvent) {
        reset();
        // Emit loading state
        emit(NewsLoadingState());
        try {
          categoryName = event.categoryName;
          final NewsRepository newsRepository = NewsRepository();
          allArticles = await newsRepository.getArticles(categoryName);
          // set search items
          searchItems.clear();
          searchItems.addAll(allArticles);

          // On successfully loading news, start lazy loading
          add(LazyLoadArticlesEvent());
        }
        // On failed loading news, emit error state
        catch (e) {
          emit(NewsErrorState());
          throw ("Error on NewsBloc: ${e.toString()}");
        }
      }

      // Lazy loading list
      if (event is LazyLoadArticlesEvent) {
        if (hasMore) {
          // Wait 1.2sec before load
          await Future.delayed(const Duration(milliseconds: 1200));

          top += limit;
          // if articles are less than start
          if (allArticles.length < top) {
            articles = allArticles;
          } else {
            articles = allArticles.getRange(0, top).toList();
          }

          if (top >= allArticles.length) hasMore = false;
        }

        emit(NewsSuccessState(articles));
      }

      // Search Articles
      else if (event is SearchArticlesEvent) {
        reset();

        List<ArticleModel> dummySearchList = [];
        dummySearchList.addAll(searchItems);

        String searchText = event.searchText.toLowerCase();

        if (searchText.isNotEmpty) {
          List<ArticleModel> dummyListData = [];
          for (ArticleModel item in dummySearchList) {
            if (item.title!.toLowerCase().contains(searchText)) {
              dummyListData.add(item);
            }
          }
          allArticles.clear();
          allArticles.addAll(dummyListData);
        } else {
          allArticles.clear();
          allArticles.addAll(searchItems);
        }

        // On successfully loading news, start lazy loading
        add(LazyLoadArticlesEvent());
      }
    });
  }
}
