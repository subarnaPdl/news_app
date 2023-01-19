import 'package:equatable/equatable.dart';
import 'package:news_app/data/models/news_article_model.dart';

class NewsState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsErrorState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<ArticleModel> articles;
  NewsSuccessState(this.articles);

  @override
  List<Object?> get props => [articles];
}
