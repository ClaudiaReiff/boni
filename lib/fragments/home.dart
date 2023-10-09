import 'package:boni/fragments/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Get.to(const QRScanner())},
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
