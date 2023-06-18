import 'package:flutter/material.dart';

class TextCenterAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final void Function() func;

  const TextCenterAppBar(
      {super.key, required this.title, required this.appBar, required this.func});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => func(),
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white24,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
