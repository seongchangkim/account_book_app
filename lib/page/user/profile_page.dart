import 'dart:convert';
import 'dart:io';

import 'package:account_book_app/api/user/user_api.dart';
import 'package:account_book_app/appbar/text_center_appbar.dart';
import 'package:account_book_app/dialog/confirm_dialog.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:account_book_app/widget/user/user_input_profile_btn.dart';
import 'package:account_book_app/widget/user/user_input_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletons/skeletons.dart';

class ProfilePage extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String tel;
  const ProfilePage(
      {super.key,
      required this.profileUrl,
      required this.tel,
      required this.name});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 이름
  final TextEditingController _nameController = TextEditingController();
  // 전화번호
  final TextEditingController _telController = TextEditingController();
  // 프로필 이미지 url
  String _profileUrl = "";

  // firebase Storage 적용
  final storageRef = FirebaseStorage.instance.ref();
  final _controller = Get.put(UserStore());

  // imagePicker 적용
  final ImagePicker _picker = ImagePicker();
  // 업로드 파일
  File? _previewFile;

  final _profileFormKey = GlobalKey<FormState>();

  // 이름, 프로필 사진 URL, 전화번호를 초기화
  @override
  void initState() {
    _nameController.text = widget.name;
    _telController.text = widget.tel;
    _profileUrl = widget.profileUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    return Scaffold(
      appBar: TextCenterAppBar(title: "MY 프로필", appBar: AppBar(), func: () => Navigator.pop(context)),
      body: SafeArea(
        child: Container(
          width: _width,
          height: _height,
          child: SingleChildScrollView(
              child: Form(
            key: _profileFormKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(30,30,30,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? file = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 100);

                      if (file == null) {
                        return;
                      }

                      setState(() {
                        _previewFile = File(file.path);
                      });
                    },
                    child: Container(
                      child: ClipOval(
                        child: _profileUrl.isEmpty && _previewFile == null
                            ? Image.asset(
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                                'assets/default-user-profile.png')
                            : (_previewFile == null
                                ? Image.network(
                                    width: 100,
                                    height: 100,
                                    _profileUrl,
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;

                                      return const Center(
                                        child: SkeletonAvatar(
                                            style: SkeletonAvatarStyle(
                                                height: 100,
                                                width: 100,
                                                shape: BoxShape.circle)),
                                      );
                                    },
                                  )
                                : Image.file(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    _previewFile!)),
                      ),
                    ),
                  ),
                  UserInputProfileForm(
                      label: "이름", controller: _nameController),
                  UserInputProfileForm(
                      label: "전화번호", controller: _telController),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.05),
                    child: Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            String? path = _previewFile != null
                                ? _previewFile!.path
                                : widget.profileUrl;

                            String id = _controller.userId;

                            if (_previewFile != null) {
                              String fileName = _previewFile!.path
                                  .toString()
                                  .substring(_previewFile!.path
                                      .toString()
                                      .lastIndexOf('/'));

                              final mountainsRef =
                                  storageRef.child("profiles/$id/$fileName");

                              await mountainsRef
                                  .putFile(_previewFile!)
                                  .then((snapShot) async {
                                path = await snapShot.ref.getDownloadURL();
                              });
                            }

                            var params = {
                              'profileUrl': path ?? '',
                              'name': _nameController.text,
                              'tel': _telController.text
                            };

                            if (_profileFormKey.currentState!.validate()) {
                              var result = await updateProfileInfo(params, id);

                              if (result["success"]) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmDialog(
                                          title: "프로필 수정",
                                          content: "프로필 정보가 수정되었습니다.",
                                          func: () => Navigator.pop(context));
                                    });
                              }
                            }
                          },
                          child: const UserInputProfileBtn(
                              text: "프로필 수정",
                              margin: EdgeInsets.only(right: 5.0),
                              color: Color.fromRGBO(34, 211, 238, 1)),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            String id = _controller.userId;

                            if (_profileFormKey.currentState!.validate()) {
                              var result = await leaveUser(id);

                              if (result["isSuccess"]) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmDialog(
                                          title: "회원 탈퇴",
                                          content: "회원 탈퇴되었습니다.",
                                          func: () =>
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/login',
                                                  (_) => false));
                                    });
                              }
                            }
                          },
                          child: const UserInputProfileBtn(
                              text: "회원 탈퇴",
                              margin: EdgeInsets.only(left: 5.0),
                              color: Color.fromRGBO(244, 63, 94, 1)),
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
