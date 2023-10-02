import 'dart:convert';

import 'package:boni/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //set
  static Future<void> storeUserInfo(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await preferences.setString("currentUser", userJson);
  }

  //get
  static Future<User?> readUserInfo() async {
    User? currentUser;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUser = User.fromJson(userDataMap);
    }
    return currentUser;
  }
}
