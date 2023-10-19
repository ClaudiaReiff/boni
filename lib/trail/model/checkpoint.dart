class Checkpoint {
  int id = 0;
  int trailId = 0;
  double longitude = 0.0;
  double latitude = 0.0;
  DateTime checkedIn = DateTime.now();

  Checkpoint(
      this.id, this.trailId, this.longitude, this.latitude, this.checkedIn);

  factory Checkpoint.fromJson(Map<String, dynamic> json) {
    Checkpoint point = Checkpoint(0, 0, 0.0, 0.0, DateTime.now());

    point.id = int.parse(json['id'].toString());
    point.trailId = int.parse(json['trailId'].toString());
    point.longitude = double.parse(json['longitude'].toString());
    point.latitude = double.parse(json['latitude'].toString());
    point.checkedIn = DateTime.parse(json['checkedIn']);

    return point;
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'trailId': trailId.toString(),
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'checkedIn': checkedIn.toIso8601String(),
      };
}
