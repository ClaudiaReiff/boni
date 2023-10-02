import 'dart:convert';

import 'package:boni/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> savePreferences(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await preferences.setString("currentUser", userJson);
  }
}
