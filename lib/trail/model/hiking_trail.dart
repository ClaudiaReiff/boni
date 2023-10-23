import 'package:boni/trail/model/checkpoint.dart';

class HikingTrail {
  int id = 0;
  String title = "";
  double length = 0.0;
  Duration duration = const Duration(hours: 0, minutes: 0, seconds: 0);
  String description = "";
  int altitude = 0;
  List<Checkpoint> checkpoints = [];

  HikingTrail();

  factory HikingTrail.fromJson(Map<String, dynamic> json) {
    HikingTrail trail = HikingTrail();

    trail.id = int.parse(json['id'].toString());
    trail.title = json['title'];
    trail.length = double.parse(json['length'].toString());
    trail.duration = _parseDuration(json['duration']);
    trail.description = json['description'];
    trail.altitude = int.parse(json['altitude'].toString());

    List<dynamic> checkpointsJson = json['checkpoints'];
    trail.checkpoints = checkpointsJson
        .map((checkpointJson) => Checkpoint.fromJson(checkpointJson))
        .toList();

    return trail;
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'title': title,
        'length': length.toString(),
        'duration': duration,
        'description': description,
        'altitude': altitude.toString(),
        'checkpoints':
            checkpoints.map((checkpoint) => checkpoint.toJson()).toList(),
      };

  //Parse duration string to duration
  static Duration _parseDuration(String durationString) {
    List<String> timeComponents = durationString.split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    int seconds = int.parse(timeComponents[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
