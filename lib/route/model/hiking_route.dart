import 'package:flutter/material.dart';

class HikingRoute {
  int id = 0;
  String name = "";
  double length = 0.0;
  Duration duration = const Duration(hours: 0, minutes: 0, seconds: 0);
  String description = "";
  int altitude = 0;
  double longitude = 0.0;
  double latitude = 0.0;

  HikingRoute();

  factory HikingRoute.fromJson(Map<String, dynamic> json) {
    HikingRoute route = HikingRoute();

    route.id = int.parse(json['id'].toString());
    route.name = json['name'];
    route.length = double.parse(json['length'].toString());
    route.duration = _parseDuration(json['duration']);
    route.description = json['description'];
    route.altitude = int.parse(json['altitude'].toString());
    route.longitude = double.parse(json['longitude'].toString());
    route.latitude = double.parse(json['latitude'].toString());

    return route;
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'length': length.toString(),
        'duration': duration,
        'description': description,
        'altitude': altitude.toString(),
        'longitude': longitude.toString(),
        'latitude': latitude.toString()
      };

  static Duration _parseDuration(String durationString) {
    List<String> timeComponents = durationString.split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    int seconds = int.parse(timeComponents[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
