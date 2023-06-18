import 'package:account_book_app/page/app_menu/more_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:account_book_app/page/app_menu/home.dart';

class AppMenuStore extends GetxController {
  int menuIndex = 0;

  Widget widget = const HomePage();

  List<Widget> widgetList = [
    const HomePage(),
    const MorePage()
  ];

  void setAppMenuPage(int index) {
    menuIndex = index;
    widget = widgetList[menuIndex];
  }
}
