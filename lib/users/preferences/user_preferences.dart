import 'dart:convert';

import 'package:boni/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //set user data to local storage
  static Future<void> storeUserInfo(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await preferences.setString("currentUser", userJson);
  }

  //returns user data from local storage
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

  //remove user data from local storage
  static Future<void> removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
