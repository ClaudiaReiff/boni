class User {
  int id = 0;
  String name = "";
  String surname = "";
  String email = "";
  String password = "";

  User(this.id, this.name, this.surname, this.email, this.password);

  factory User.fromJson(Map<String, dynamic> json) => User(
      int.parse(json['id']),
      json["name"],
      json["surname"],
      json["email"],
      json["password"]);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
      };
}
