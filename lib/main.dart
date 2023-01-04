import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/routes/routes.dart';
import 'package:news_app/routes/routes_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return const MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes,
      initialRoute: RouteConstant.splashScreen,
    );
  }
}
