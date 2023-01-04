import 'package:equatable/equatable.dart';
import 'package:news_app/home_screen/data/models/article_model.dart';

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
}
