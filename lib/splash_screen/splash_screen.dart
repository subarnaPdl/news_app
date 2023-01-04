import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/routes/routes_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pause two seconds in SplashScreen
    // then goto HomeScreen
    Timer(const Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacementNamed(RouteConstant.homeScreen);
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: const Center(
        child: FlutterLogo(size: 100), // Flutter default logo
      ),
    );
  }
}
