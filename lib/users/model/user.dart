class User {
  int id = 0;
  String name = "";
  String surname = "";
  String email = "";
  String password = "";

  User(this.id, this.name, this.surname, this.email, this.password);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
      };
}
