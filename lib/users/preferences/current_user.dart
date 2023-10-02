import 'package:boni/users/model/user.dart';
import 'package:boni/users/preferences/user_preferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController {
  final Rx<User> _currentUser = User(0, '', '', '', '').obs;

  User get user => _currentUser.value;

  getUserInfo() async {
    User? userInfo = await UserPreferences.readUserInfo();
    _currentUser.value = userInfo!;
  }
}
