import 'package:flutter/material.dart';
import 'package:news_app/home_screen/presentation/home_screen.dart';
import 'package:news_app/routes/routes_constant.dart';
import 'package:news_app/splash_screen/splash_screen.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstant.splashScreen:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case RouteConstant.homeScreen:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
