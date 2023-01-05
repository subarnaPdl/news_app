import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';
import 'package:news_app/home_screen/data/repo/news_repo.dart';

import '../bloc/news_event.dart';
import '../bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<ArticleModel> articles = [];
  List<ArticleModel> searchItems = [];

  NewsBloc() : super(NewsInitialState()) {
    on<NewsEvent>((event, emit) async {
      // Get Articles
      if (event is GetArticlesEvent) {
        // Emit loading state
        emit(NewsLoadingState());
        try {
          String categoryName = event.categoryName;
          final NewsRepository newsRepository = NewsRepository();
          articles = await newsRepository.getArticles(categoryName);
          // On successfully loading news, emit success state
          emit(NewsSuccessState(articles));
        }
        // On failed loading news, emit error state
        catch (e) {
          emit(NewsErrorState());
          throw ("Error on NewsBloc: ${e.toString()}");
        }
      }

      // Search Articles
      else if (event is SearchArticlesEvent) {
        // Emit loading state
        emit(NewsLoadingState());
        searchItems.addAll(articles);
        print(searchItems);

        List<ArticleModel> dummySearchList = [];
        dummySearchList.addAll(searchItems);
        String searchText = event.searchText;

        if (searchText.isNotEmpty) {
          List<ArticleModel> dummyListData = [];
          for (ArticleModel item in dummySearchList) {
            if (item.title!.toLowerCase().contains(searchText)) {
              dummyListData.add(item);
            }
          }
          articles.clear();
          articles.addAll(dummyListData);
        } else {
          articles.clear();
          articles.addAll(searchItems);
        }
        emit(NewsSuccessState(articles));
      }
    });
  }
}
