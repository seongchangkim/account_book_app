import 'dart:convert';
import 'dart:developer';

import 'package:account_book_app/global/user_global.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:account_book_app/global/env/env.dart';

final _controller = Get.put(UserStore());

const BASE_URL = Env.baseUrl;

// 회원가입
Future<String> signUp(
    String email, String password, String name, String tel) async {
  var param = {"email": email, "password": password, "name": name, "tel": tel};
  Uri url = Uri.parse("${BASE_URL}/api/user");
  var res = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(param));

  return res.body;
}

// 로그인
Future<dynamic> login(String email, String password) async {
  var param = {"email": email, "password": password};
  Uri url = Uri.parse("${BASE_URL}/api/user/login");
  var res = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(param));

  var data = json.decode(res.body);

  await storage.write(key: "x_auth", value: data["token"]);
  await storage.write(key: "userId", value: data["userId"].toString());

  return res.body;
}

// 로그아웃
Future<dynamic> logout(String userId) async {
  var param = {"userId": userId};
  Uri url = Uri.parse("${BASE_URL}/api/user/logout");

  var res = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(param));

  var data = json.decode(res.body);

  await storage.delete(key: "x_auth");
  await storage.delete(key: "user_id");

  _controller.setUserInfo("", data["token"] ?? "", "", "", "", "");

  return res.body;
}

// 로그인 여부
Future<bool> checkAuth(String token) async {
  var param = {"token": token};

  Uri url = Uri.parse("${BASE_URL}/api/user/auth");

  var res = await http.post(url,
      headers: {"Content-Type": "application/json"},
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(param));

  var data = json.decode(res.body);

  log("data : ${data}");

  _controller.setUserInfo(
      data["id"].toString(),
      data["token"] ?? "",
      data["name"] ?? "",
      data["profileUrl"] ?? "",
      data["role"] ?? "",
      data["tel"] ?? "");

  return data["auth"];
}

// 카카오 로그인
Future<void> kakaoLogin(String oauthToken, String id) async {
  var param = {"oauthToken": oauthToken, "id": id};

  Uri url = Uri.parse("${BASE_URL}/api/user/social-login/kakao");

  await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(param));

  await storage.write(key: "x_auth", value: oauthToken);
  await storage.write(key: "userId", value: id);

  _controller.setToken(oauthToken);
}

// 소셜 로그인 회원 존재 여부
Future<bool> isExistSocialUser(
    String email, String name, String socialType) async {
  var param = {"email": email, "name": name, "socialType": socialType};

  Uri url = Uri.parse("${BASE_URL}/api/user/social-login/exist");

  var res = await http.post(url,
      headers: {"Content-Type": "application/json"},
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(param));

  var data = json.decode(res.body);

  log("data : ${data}");

  _controller.setUserId(data["id"].toString());

  return data["exist"];
}

// 프로필 수정
Future<dynamic> updateProfileInfo(dynamic params, String userId) async {
  Uri url = Uri.parse("${BASE_URL}/api/profile/$userId");

  var res = await http.patch(url,
      headers: {"Content-Type": "application/json"},
      encoding: Encoding.getByName("utf-8"),
      body: json.encode(params));

  var data = json.decode(res.body);

  print("data : ${data}");
  _controller.updateProfileInfo(
      data["name"] ?? '', data["tel"] ?? '', data["profileUrl"] ?? '');

  return data;
}

// 회원 탈퇴
Future<dynamic> leaveUser(String userId) async {
  Uri url = Uri.parse("${BASE_URL}/api/user/$userId");

  var res = await http.delete(url,
      headers: {"Content-Type": "application/json"},
      encoding: Encoding.getByName("utf-8"));

  return json.decode(res.body);
}
