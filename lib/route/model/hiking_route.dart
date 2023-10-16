class HikingRoute {
  int id = 0;
  String name = "";
  String description = "";
  double length = 0.0;
  String duration = "";
  double altitude = 0.0;
  String coordinates = "";

  HikingRoute(this.id, this.name, this.description, this.length, this.duration,
      this.altitude, this.coordinates);

  factory HikingRoute.fromJson(Map<String, dynamic> json) => HikingRoute(
      int.parse(json['id']),
      json["name"],
      json["description"],
      json["length"],
      json["duration"],
      json["altitude"],
      json["coordinates"]);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'description': description,
        'length': length.toString(),
        'duration': duration,
        'altitude': altitude.toString(),
        'coordinates': coordinates
      };
}
