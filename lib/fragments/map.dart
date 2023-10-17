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
      position: const LatLng(47.18204341853182, 12.229012076544146),
      infoWindow: const InfoWindow(title: "Seebachsee im Obersulzbachtal"),
      onTap: () {
        Get.to(const RoutePage(
          id: 1,
        ));
      },
    )
  ];

  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(47.18204341853182, 12.229012076544146), zoom: 12);

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
          markerId: const MarkerId('My Location'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'My Location')));

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
