import 'package:get_it/get_it.dart';
import 'package:news_app/data/data_source/remote_data_source/news_repo.dart';
import 'package:news_app/modules/presentation/home/controller/controller.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<HomeScreenController>(() => HomeScreenController());
  locator.registerFactory<NewsRepository>(() => NewsRepository());
}
