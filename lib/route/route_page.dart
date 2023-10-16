import 'dart:async';
import 'dart:convert';

import 'package:boni/fragments/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:boni/api/api_connection.dart';
import 'package:get/get.dart';

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
    getRoute();
  }

  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(33.67809150625739, 73.0143207993158), zoom: 12);

  void setFavourite() {}

  getRoute() async {
    try {
      var response = await http
          .post(Uri.parse(API.getRoute), body: {'id': widget.id.toString()});
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          print("Route successfully fetched");
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialPosition,
                mapType: MapType.normal,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Route 1',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.white),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '10 points',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
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
                      child: const InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 28),
                          child: Center(
                            child: Text(
                              "Check-in",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          side: MaterialStateProperty.all(const BorderSide(
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.height,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '46,8 km',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '1.587 hm',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '04:00 h',
                          style: TextStyle(
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
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Die Wanderung beginnt am Fuße des malerischen Berges und führt dich entlang eines gut gepflegten Pfades durch dichte Wälder und sanfte Hügel. Während des Aufstiegs wirst du mit atemberaubenden Panoramablicken auf umliegende Berge und Täler belohnt. Der Pfad ist abwechslungsreich und bietet sowohl schattige Abschnitte als auch sonnige Plätze, um eine Pause einzulegen und die Natur zu genießen. Unterwegs findest du auch natürliche Quellen, an denen du dich erfrischen kannst.',
                        style: TextStyle(
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
    ));
  }
}
