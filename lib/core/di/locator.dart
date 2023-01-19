import 'package:get_it/get_it.dart';
import 'package:news_app/modules/presentation/home/controller/controller.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<HomeScreenController>(() => HomeScreenController());
}
