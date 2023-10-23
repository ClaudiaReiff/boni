class Checkpoint {
  int id = 0;
  String name = '';
  int trailId = 0;
  double latitude = 0.0;
  double longitude = 0.0;

  Checkpoint(this.id, this.name, this.trailId, this.latitude, this.longitude);

  factory Checkpoint.fromJson(Map<String, dynamic> json) {
    Checkpoint point = Checkpoint(0, '', 0, 0.0, 0.0);

    point.id = int.parse(json['id'].toString());
    point.name = json['name'];
    point.trailId = int.parse(json['trailId'].toString());
    point.latitude = double.parse(json['latitude'].toString());
    point.longitude = double.parse(json['longitude'].toString());

    return point;
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'trailId': trailId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      };
}
