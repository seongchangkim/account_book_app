import 'package:flutter/material.dart';

class AppMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final Color color;

  const AppMenuAppBar(
      {super.key,
      required this.title,
      required this.appBar,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
