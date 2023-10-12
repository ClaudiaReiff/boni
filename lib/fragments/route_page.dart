import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget {
  final int id;
  const RoutePage({super.key, required this.id});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Route Page")),
    );
  }
}
