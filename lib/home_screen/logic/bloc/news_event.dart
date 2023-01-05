import 'package:equatable/equatable.dart';

class NewsEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetArticlesEvent extends NewsEvent {
  final String categoryName;
  GetArticlesEvent({this.categoryName = "general"});
}

class SearchArticlesEvent extends NewsEvent {
  final String searchText;

  SearchArticlesEvent({required this.searchText});
}
