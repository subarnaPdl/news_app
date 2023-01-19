import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news_app/core/di/locator.dart';
import 'package:news_app/core/routes/routes.dart';
import 'package:news_app/core/routes/routes_constant.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
