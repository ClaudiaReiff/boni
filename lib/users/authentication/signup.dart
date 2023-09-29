import 'package:boni/users/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  var isObsecure = true.obs;

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
                      height: 400,
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
                            SizedBox(
                              width: double.infinity,
                              child: Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: () {},
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
