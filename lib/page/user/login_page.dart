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
        margin: EdgeInsets.symmetric(horizontal: _width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "LOGO",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "아직 회원이 아닙니까? ",
                            style: TextStyle(fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/signUp'),
                            child: const Text("회원가입",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    fontSize: 13)),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          // 로그인 폼 유효성 검사 통과하면
                          if (_loginForm.currentState!.validate()) {
                            // 로그인
                            var res = await login(
                              emailController.text,
                              passwordController.text,
                            );

                            var result = json.decode(res);

                            if (result["errorMessage"] == null) {
                              await successLoginRedirectPage(result["token"]);
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
                          try {
                            OAuthToken oauthToken = await isKakaoTalkInstalled()
                              ? await UserApi.instance.loginWithKakaoTalk()
                              : await UserApi.instance.loginWithKakaoAccount();

                            var token = oauthToken.toJson();

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

                            print("profileInfo : $profileInfo");
                            var isExistRes = await isExistSocialUser(
                                profileInfo["kakao_account"]["email"],
                                profileInfo["kakao_account"]["profile"]
                                    ["nickname"],
                                "KAKAO");

                            if (isExistRes) {
                              await kakaoLogin(token["access_token"],
                                      userController.userId)
                                  .then((value) async =>
                                      successLoginRedirectPage(
                                          token["access_token"]));
                              return;
                            }

                            bool isSucess = await Navigator.pushNamed(
                                context, "/socialLogin",
                                arguments: {
                                  'email': profileInfo["kakao_account"]
                                      ["email"],
                                  'name': profileInfo["kakao_account"]
                                      ["profile"]["nickname"]
                                }) as bool;

                            if (isSucess) {
                              await kakaoLogin(token["access_token"],
                                      userController.userId)
                                  .then((value) async =>
                                      successLoginRedirectPage(
                                          token["access_token"]));
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
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: _width * 0.02),
                          height: _height * 0.07,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.black12)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/kakao-logo-yellow.png",
                                    width: 40, height: 40),
                                const Text(
                                  " 카카오 로그인",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ))
                  ],
                ))
          ],
        ),
      ))),
    );
  }

  // 로그인 및 소셜 로그인 공통 처리 메소드(토큰 유효성 검사 및 홈 화면으로 리다이렉트)
  Future<void> successLoginRedirectPage(String token) async {
    await checkAuth(token).then((isAuth) {
      if (isAuth) {
        menuController.setAppMenuPage(0);

        // 홈화면으로 이동
        Navigator.pushNamedAndRemoveUntil(
            context, "/appMenu", (route) => false);
      }
    });
  }
}
