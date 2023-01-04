import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';
import 'package:news_app/home_screen/data/repo/news_repo.dart';

import '../bloc/news_event.dart';
import '../bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitialState()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetArticlesEvent) {
        // Emit loading state
        emit(NewsLoadingState());
        try {
          String categoryName = event.categoryName;
          final NewsRepository newsRepository = NewsRepository();
          List<ArticleModel> articles =
              await newsRepository.getArticles(categoryName);
          // On successfully loading news, emit success state
          emit(NewsSuccessState(articles));
        }
        // On failed loading news, emit error state
        catch (e) {
          emit(NewsErrorState());
          throw ("Error on NewsBloc: ${e.toString()}");
        }
      }
    });
  }
}
