import 'dart:async';
import 'package:boni/route/route_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  State<Maps> createState() => _Maps();
}

class _Maps extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
    Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(33.67809150625739, 73.0143207993158),
      infoWindow: const InfoWindow(title: "Route 1"),
      onTap: () {
        Get.to(const RoutePage(
          id: 1,
        ));
      },
    )
  ];

  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(33.67809150625739, 73.0143207993158), zoom: 12);

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }

  packData() {
    getUserLocation().then((value) async {
      print('My Location');
      print('${value.latitude} ${value.longitude}');

      myMarker.add(Marker(
          markerId: const MarkerId('5'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'Location')));

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 10);

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 24.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            child: const Icon(Icons.location_searching),
            onPressed: () async {
              packData();
            },
          ),
        ),
      ),
    );
  }
}
