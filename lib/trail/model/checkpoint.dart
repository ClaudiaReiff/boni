class Checkpoint {
  int id = 0;
  double longitude = 0.0;
  double latitude = 0.0;
  int trailId = 0;
  DateTime checkedIn = DateTime.now();

  Checkpoint();

  factory Checkpoint.fromJson(Map<String, dynamic> json) {
    Checkpoint point = Checkpoint();

    point.id = int.parse(json['id'].toString());
    point.longitude = double.parse(json['longitude'].toString());
    point.latitude = double.parse(json['latitude'].toString());
    point.trailId = int.parse(json['trailId'].toString());

    return point;
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'trailId': trailId.toString(),
      };
}
