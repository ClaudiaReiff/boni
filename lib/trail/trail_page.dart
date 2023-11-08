import 'dart:async';
import 'dart:convert';

import 'package:boni/fragments/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:boni/api/api_connection.dart';
import 'package:get/get.dart';
import 'package:boni/trail/model/hiking_trail.dart';

class TrailPage extends StatefulWidget {
  final int id;
  const TrailPage({super.key, required this.id});

  @override
  State<TrailPage> createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {
  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
    Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(47.206145349025235, 12.25229168119671),
      infoWindow: const InfoWindow(title: "Start"),
      onTap: () {
        Get.to(const TrailPage(
          id: 1,
        ));
      },
    ),
    Marker(
      markerId: const MarkerId('2'),
      position: const LatLng(47.18224829152682, 12.231391908429206),
      infoWindow: const InfoWindow(title: "See"),
      onTap: () {
        Get.to(const TrailPage(
          id: 1,
        ));
      },
    ),
    Marker(
      markerId: const MarkerId('3'),
      position: const LatLng(47.206145349025235, 12.25229168119671),
      infoWindow: const InfoWindow(title: "Ende"),
      onTap: () {
        Get.to(const TrailPage(
          id: 1,
        ));
      },
    )
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
  }

  void setFavourite() {}

  Future<HikingTrail> getTrail() async {
    HikingTrail trail = HikingTrail();
    try {
      var response = await http
          .post(Uri.parse(API.getTrail), body: {'id': widget.id.toString()});
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          trail = HikingTrail.fromJson(resBody["trailData"]);
        }
      }
    } catch (e) {}
    return trail;
  }

  String getDuration(HikingTrail? trail) {
    if (trail != null) {
      int hours = trail.duration.inHours;
      int minutes = trail.duration.inMinutes % 60;
      return '$hours:$minutes h';
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<HikingTrail>(
        future: getTrail(),
        builder: (BuildContext context, AsyncSnapshot<HikingTrail> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final trail = snapshot.data;
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                trail?.checkpoints[0].latitude ?? 0.0,
                                trail?.checkpoints[0].longitude ?? 0.0),
                            zoom: 12),
                        mapType: MapType.normal,
                        markers: Set<Marker>.of(myMarker),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                      Positioned(
                          top: 16,
                          left: 16,
                          child: InkWell(
                            onTap: () {
                              Get.to(Maps());
                            },
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.black,
                              size: 30,
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.black,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              trail?.title ?? "",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 28),
                                  child: Center(
                                    child: Text(
                                      "Start",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: OutlinedButton.icon(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: Colors.blue, width: 2.0))),
                              label: const Text('Favourite'),
                              icon: const Icon(Icons.star_outline),
                              onPressed: () {
                                setFavourite();
                              },
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.height,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  trail?.length.toString() ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  " km",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  trail?.altitude.toString() ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  " hm",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  getDuration(trail),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        const Row(
                          children: [
                            Text('Beschreibung',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                trail?.description ?? "",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
