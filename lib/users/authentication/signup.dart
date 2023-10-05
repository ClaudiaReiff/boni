import 'dart:convert';

import 'package:boni/api/api_connection.dart';
import 'package:boni/users/authentication/login.dart';
import 'package:boni/users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isObsecure = true.obs;

  void validateUserEmail() async {
    try {
      var response = await http.post(Uri.parse(API.validateEmail),
          body: {'email': emailController.text});

      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['emailFound']) {
          Fluttertoast.showToast(
              msg: "Email is already in use. Try another email.");
        } else {
          saveUser();
        }
      }
    } catch (e) {}
  }

  void saveUser() async {
    User user = User(
        0,
        nameController.text.trim(),
        surnameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim());

    try {
      var response =
          await http.post(Uri.parse(API.signUp), body: user.toJson());
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "Signed up successfully.");
          setState(() {
            nameController.clear();
            surnameController.clear();
            emailController.clear();
            passwordController.clear();
          });
          Get.to(const Login());
        } else {
          Fluttertoast.showToast(msg: "Error occured. Please try again.");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 360,
                      child: Image.asset(
                        "images/register.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        top: 16,
                        left: 16,
                        child: InkWell(
                          onTap: () {
                            Get.to(const Login());
                          },
                          child: const Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3))
                      ]),
                  child: Column(
                    children: [
                      const Text(
                        "Boni",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      //log-in form
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
                        child: Form(
                          key: formKey,
                          child: Column(children: [
                            //name
                            TextFormField(
                              controller: nameController,
                              validator: (val) =>
                                  val == "" ? "Please enter name" : null,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  contentPadding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 14, vertical: 6),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                            const SizedBox(height: 15),
                            //surname
                            TextFormField(
                              controller: surnameController,
                              validator: (val) =>
                                  val == "" ? "Please enter surname" : null,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintText: "Surname",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  contentPadding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 14, vertical: 6),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                            const SizedBox(height: 18),
                            //email
                            TextFormField(
                              controller: emailController,
                              validator: (val) =>
                                  val == "" ? "Please enter email" : null,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60)),
                                  contentPadding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 14, vertical: 6),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                            const SizedBox(height: 18),
                            //password
                            Obx(() => TextFormField(
                                  controller: passwordController,
                                  obscureText: isObsecure.value,
                                  validator: (val) => val == ""
                                      ? "Please enter password"
                                      : null,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Obx(() => GestureDetector(
                                            onTap: () {
                                              isObsecure.value =
                                                  !isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                          )),
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60)),
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 14, vertical: 6),
                                      fillColor: Colors.white,
                                      filled: true),
                                )),
                            const SizedBox(height: 18),
                            SizedBox(
                              width: double.infinity,
                              child: Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      //validate email
                                      validateUserEmail();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 28),
                                    child: Center(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
