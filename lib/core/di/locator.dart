import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/data_source/remote_data_source/news_repo.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<NewsRepository>(() => NewsRepository());
}
