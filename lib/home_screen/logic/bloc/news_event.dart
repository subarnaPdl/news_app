import 'package:equatable/equatable.dart';

class NewsEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetArticlesEvent extends NewsEvent {
  final String categoryName;

  // Initially show topheadlines
  // But when category is specified, show results accordingly
  GetArticlesEvent({this.categoryName = 'topheadlines'});
}
