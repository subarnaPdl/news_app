import 'package:flutter/material.dart';
import 'package:news_app/theme/uiparameters.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
      margin: null,
      padding: const EdgeInsets.only(left: 10),
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
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        shrinkWrap: true,
        children: [
          listTile(
              text: 'Home',
              onClick: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}

ListTile listTile({required String text, required Function()? onClick}) {
  return ListTile(
    visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    title: Text(text, style: const TextStyle(fontSize: 15)),
    onTap: onClick,
  );
}
