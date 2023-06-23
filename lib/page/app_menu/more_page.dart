import 'package:account_book_app/appbar/menu_select_appbar.dart';
import 'package:account_book_app/store/menu_store.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:account_book_app/widget/others/more_page_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:account_book_app/api/user/user_api.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
    with AutomaticKeepAliveClientMixin {
  final _userController = Get.put(UserStore());
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    return Scaffold(
      appBar: AppMenuAppBar(title: "더보기", appBar: AppBar(), color: Colors.white24),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: _width,
            height: _height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1.0)
                    )
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: _width,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: const Text(
                          "게정 관리",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          )),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          var params = {
                            'profileUrl': _userController.profileUrl,
                            'tel': _userController.tel,
                            'name': _userController.name
                          };
                          Navigator.pushNamed(context, "/profile",
                              arguments: params);
                        },
                        child: const MorePageContainer(text: "MY 프로필"),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          await logout(_userController.userId);

                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (route) => false);
                        },
                        child: const MorePageContainer(text: "로그아웃"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
