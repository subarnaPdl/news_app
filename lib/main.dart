import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_app/core/di/locator.dart';
import 'package:news_app/core/routes/routes.dart';
import 'package:news_app/core/routes/routes_constant.dart';
import 'package:news_app/data/data_source/remote_data_source/news_repo.dart';

import 'modules/presentation/home/controller/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup locator for DI
  setupLocator();

  // Lock in portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Make status bar transparent throughout the app
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final HomeScreenController homeScreenController = Get.put(locator());
  final NewsRepository newsRepository = Get.put(locator());

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes,
      initialRoute: RouteConstant.splashScreen,
    );
  }
}
