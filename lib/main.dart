import 'package:boni/fragments/navigation.dart';
import 'package:boni/users/authentication/login.dart';
import 'package:boni/users/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Boni',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: UserPreferences.readUserInfo(),
          //automatically login if user info given
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Navigation();
            } else {
              return Navigation();
            }
          },
        ));
  }
}
