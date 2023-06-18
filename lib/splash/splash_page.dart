import 'package:account_book_app/api/user/user_api.dart';
import 'package:flutter/material.dart';
import 'package:account_book_app/global/user_global.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Future myFuture;

  @override
  void initState() {
    myFuture = initCheckAuthApp();
    super.initState();
  }

  Future<void> initCheckAuthApp() async {
    String token = await storage.read(key: "x_auth") ?? "";

    // 로그인 체크
    bool isAuth = await checkAuth(token);

    if (isAuth) {
      Navigator.pushNamedAndRemoveUntil(context, "/appMenu", (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: Colors.lightBlue),
        width: width,
        height: height,
        child: const Center(
            child: Text("account",
                style: TextStyle(color: Colors.white, fontSize: 28))),
      )),
    );
  }
}
