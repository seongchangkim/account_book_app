import 'dart:convert';
import 'dart:developer';

import 'package:account_book_app/dialog/confirm_dialog.dart';
import 'package:account_book_app/widget/user/user_input_btn.dart';
import 'package:account_book_app/widget/user/user_input_form.dart';
import 'package:flutter/material.dart';
import 'package:account_book_app/api/user/user_api.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  final String name;
  final String email;
  final bool isSocialLogin;

  const SignUpPage(
      {super.key, this.name = '', this.email = '', this.isSocialLogin = false});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userController = Get.put(UserStore());
  final _signUpForm = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.name != '' ? widget.name : '';
    _emailController.text = widget.email != '' ? widget.email : '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context, false),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black)
        ),
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
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
              "회원가입",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            Form(
                //
                key: _signUpForm,
                child: Column(
                  children: [
                    UserInputForm(
                      labelText: "이메일",
                      controller: _emailController,
                      inputType: "email",
                      isWriteInputForm: widget.isSocialLogin ? true : false,
                    ),
                    if (!widget.isSocialLogin)
                      UserInputForm(
                        labelText: "비밀번호",
                        controller: _passwordController,
                        inputType: "password",
                      ),
                    UserInputForm(
                      labelText: "이름",
                      controller: _nameController,
                      inputType: "name",
                      isWriteInputForm: widget.isSocialLogin ? true : false,
                    ),
                    UserInputForm(
                      labelText: "전화번호",
                      controller: _telController,
                      inputType: "tel",
                      isMoveNextCursor: false,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (_signUpForm.currentState!.validate()) {
                            var res = await signUp(
                                _emailController.text,
                                _passwordController.text,
                                _nameController.text,
                                _telController.text);

                            var result = json.decode(res);

                            // print("result : ${result.toString()}");
                            if (result["message"] != null &&
                                !widget.isSocialLogin) {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return ConfirmDialog(
                                        title: "회원가입",
                                        content: result["message"],
                                        func: navigatorLoginPage);
                                  }));
                            } else if (result["message"] != null &&
                                widget.isSocialLogin) {
                              userController.setUserId(result["userId"].toString());
                              Navigator.pop(context, true);
                            }
                          }
                        },
                        child: const UserInputBtn(
                          btnText: "회원가입",
                        ))
                  ],
                ))
          ],
        ),
      ))),
    );
  }

  void navigatorLoginPage() {
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
