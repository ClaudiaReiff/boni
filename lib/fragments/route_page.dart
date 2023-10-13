import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePage extends StatefulWidget {
  final int id;
  const RoutePage({super.key, required this.id});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    print('ID: ${widget.id}');
  }

  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(33.67809150625739, 73.0143207993158), zoom: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    ));
  }
}
