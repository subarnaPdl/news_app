import 'package:flutter/material.dart';
import 'package:news_app/home_screen/presentation/home_screen.dart';
import 'package:news_app/news_screen/news_screen.dart';
import 'package:news_app/routes/routes_constant.dart';
import 'package:news_app/splash_screen/splash_screen.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstant.splashScreen:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case RouteConstant.homeScreen:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case RouteConstant.newsScreen:
      return MaterialPageRoute(builder: (_) => const NewsScreen());

    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
