import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/modules/presentation/home/home_screen.dart';
import 'package:news_app/theme/uiparameters.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIParameters.getWidth(context) * 0.7,
      child: Drawer(
        child: Column(
          children: [
            drawerHeader(context),
            const SizedBox(height: 10),
            drawerBody(context),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            FlutterLogo(size: 48),
            SizedBox(height: 20),
            Text(
              'News App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawerBody(BuildContext context) {
    List categories = [
      'general',
      'business',
      'entertainment',
      'health',
      'science',
      'sports',
      'technology',
    ];

    String selectedCategory = HomeScreenController.to.categoryName;

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        shrinkWrap: true,
        children: [
          for (String category in categories)
            listTile(
                // Capitalize first letter
                text: category.toUpperCase().substring(0, 1) +
                    category.substring(1).toLowerCase(),
                isSelected: category == selectedCategory,
                onClick: () {
                  // fetch articles based on category
                  HomeScreenController.to.getArticles(categoryName: category);
                  Get.back();
                }),
        ],
      ),
    );
  }
}

ListTile listTile(
    {required String text,
    required bool isSelected,
    required Function()? onClick}) {
  return ListTile(
    visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    tileColor: isSelected ? Colors.grey[300] : null,
    title: Text(text, style: const TextStyle(fontSize: 15)),
    onTap: onClick,
  );
}
