import 'dart:convert';
import 'dart:io';

import 'package:account_book_app/api/user/user_api.dart';
import 'package:account_book_app/dialog/error_dialog.dart';
import 'package:account_book_app/store/menu_store.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:account_book_app/widget/user/user_input_btn.dart';
import 'package:account_book_app/widget/user/user_input_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginForm = GlobalKey<FormState>();
  final userController = Get.put(UserStore());
  final menuController = Get.put(AppMenuStore());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        width: _width,
        height: _height,
        margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "로그인",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Form(
                //
                key: _loginForm,
                child: Column(
                  children: [
                    UserInputForm(
                      labelText: "이메일",
                      controller: emailController,
                      inputType: "email",
                    ),
                    UserInputForm(
                      labelText: "비밀번호",
                      controller: passwordController,
                      inputType: "password",
                      isMoveNextCursor: false,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/signUp"),
                              child: const Text("회원가입"))
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          //
                          if (_loginForm.currentState!.validate()) {
                            var res = await login(
                              emailController.text,
                              passwordController.text,
                            );

                            var result = json.decode(res);

                            if (result["errorMessage"] == null) {
                              await checkAuth(result["token"]).then((isAuth) {
                                if (isAuth) {
                                  menuController.setAppMenuPage(0);
                                  // 홈화면으로 이동
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/appMenu", (route) => false);
                                }
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return ErrorDialog(
                                        content: result["errorMessage"]);
                                  }));
                            }
                          }
                        },
                        child: const UserInputBtn(
                          btnText: "로그인",
                        )),
                    GestureDetector(
                      onTap: () async {
                        OAuthToken oauthToken = await isKakaoTalkInstalled()
                            ? await UserApi.instance.loginWithKakaoTalk()
                            : await UserApi.instance.loginWithKakaoAccount();

                        try {
                          // print('카카오톡으로 로그인 성공');

                          var token = oauthToken.toJson();

                          print("accessToken : ${token["access_token"]}");
                          final url =
                              Uri.https('kapi.kakao.com', '/v2/user/me');

                          final response = await http.get(
                            url,
                            headers: {
                              HttpHeaders.authorizationHeader:
                                  'Bearer ${oauthToken.accessToken}'
                            },
                          );

                          final profileInfo = json.decode(response.body);

                          var isExistRes = await isExistSocialUser(
                              profileInfo["kakao_account"]["email"],
                              profileInfo["kakao_account"]["profile"]
                                  ["nickname"],
                              "KAKAO");

                          if (isExistRes) {
                            await kakaoLogin(token["access_token"],
                                    userController.userId)
                                .then((value) async =>
                                    await checkAuth(token["access_token"])
                                        .then((isAuth) {
                                      print("isAuth : $isAuth");

                                      if (isAuth) {
                                        menuController.setAppMenuPage(0);

                                        // 홈화면으로 이동
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "/appMenu",
                                            (route) => false);
                                      }
                                    }));

                            return;
                          }

                          bool isSucess = await Navigator.pushNamed(
                              context, "/socialLogin",
                              arguments: {
                                'email': profileInfo["kakao_account"]["email"],
                                'name': profileInfo["kakao_account"]["profile"]
                                    ["nickname"]
                              }) as bool;

                          print("token : ${token["access_token"]}");
                          if (isSucess) {
                            await kakaoLogin(
                                token["access_token"], userController.userId)
                                  .then((value) async {
                                    await checkAuth(token["access_token"])
                                        .then((isAuth) {
                                      // print("isAuth : $isAuth");
                                      if (isAuth) {
                                        menuController.setAppMenuPage(0);

                                        // 홈화면으로 이동
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, "/appMenu", (route) => false);
                                      }
                                    });
                                  });
                          }
                        } catch (error) {
                          print('카카오톡으로 로그인 실패 $error');

                          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                          if (error is PlatformException &&
                              error.code == 'CANCELED') {
                            return;
                          }
                        }
                      },
                      child: Image.asset("assets/kakao_login_medium_wide.png"),
                    )
                  ],
                ))
          ],
        ),
      ))),
    );
  }
}
