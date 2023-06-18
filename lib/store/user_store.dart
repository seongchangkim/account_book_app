import 'package:get/get_state_manager/get_state_manager.dart';

class UserStore extends GetxController {
  String userId = "";
  String token = "";
  String name = "";
  String profileUrl = "";
  String role = "";
  String tel = "";

  void setUserInfo(String userId, String token, String name, String profileUrl,
      String role, String tel) {
    this.userId = userId;
    this.token = token;
    this.name = name;
    this.profileUrl = profileUrl;
    this.role = role;
    this.tel = tel;
    update();
  }

  void updateProfileInfo(String name, String tel, String profileUrl) {
    this.name = name;
    this.tel = tel;
    this.profileUrl = profileUrl;
  }

  void setUserId(String userId) {
    this.userId = userId;
    update();
  }

  void setToken(String token) {
    this.token = token;
    update();
  }
}
