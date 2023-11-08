import 'package:boni/fragments/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The home screen of the application.
class Home extends StatelessWidget {
  /// Constructor
  const Home({super.key});

  /// Builds the widget for the home screen
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
