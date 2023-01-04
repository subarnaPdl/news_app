import 'package:flutter/material.dart';
import 'package:news_app/widgets/sidemenu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      drawer: const SideMenu(),
      body: const Text('Home Screen'),
    );
  }
}
