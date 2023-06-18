import 'package:account_book_app/store/menu_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppMenuSelect extends StatefulWidget {
  const AppMenuSelect({super.key});

  @override
  State<AppMenuSelect> createState() => _AppMenuSelectState();
}

class _AppMenuSelectState extends State<AppMenuSelect> {
  // 메뉴바 관련 상태 저장소
  final _menuController = Get.put(AppMenuStore());
  PageController _pageController = PageController();

  final List<BottomNavigationBarItem> _bottomMenuBarItemList = const [
    BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ""),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.bars), label: ""),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = _menuController.widgetList;
    int menuIndex = _menuController.menuIndex;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
            child: PageView(
          // 탭 페이지 변경
          onPageChanged: (index) {
            setState(() {
              menuIndex = index;
            });
          },
          controller: _pageController,
          // 옆으로 드래그하면 페이지를 넘기지 않도록 방지
          physics: const NeverScrollableScrollPhysics(),
          children: widgetList,
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: _bottomMenuBarItemList,
          currentIndex: menuIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: (index) {
            _pageController.jumpToPage(index);
            _menuController.setAppMenuPage(index);
          }),
    );
  }
}
