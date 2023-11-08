class User {
  String id = "";
  String name = "";
  String surname = "";
  String email = "";
  String password = "";

  User(this.id, this.name, this.surname, this.email, this.password);

  factory User.fromJson(Map<String, dynamic> json) => User(
      json["id"].toString(),
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
