import 'package:boni/users/authentication/login.dart';
import 'package:boni/users/preferences/current_user.dart';
import 'package:boni/users/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final CurrentUser currentUser = Get.put(CurrentUser());

  signOutUser() async {
    var response = await Get.dialog(AlertDialog(
      backgroundColor: Colors.grey,
      title: const Text(
        "Logout",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: const Text("Do you really want to logout?"),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "No",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: "loggedOut");
          },
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    ));
    if (response == 'loggedOut') {
      //remove user data from local storage
      UserPreferences.removeUserInfo().then((value) {
        Get.off(const Login());
      });
    }
  }

  Widget userProfileInfo(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(iconData, size: 30, color: Colors.black),
          const SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Center(
          child: ClipOval(
            child: Image.asset(
              "images/profile.jpg",
              width: 230,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        userProfileInfo(Icons.person, currentUser.user.name),
        const SizedBox(height: 20),
        userProfileInfo(Icons.person, currentUser.user.surname),
        const SizedBox(height: 20),
        userProfileInfo(Icons.email, currentUser.user.email),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              //Sign out user
              onTap: () {
                signOutUser();
              },
              borderRadius: BorderRadius.circular(30),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
