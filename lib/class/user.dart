class User {
  final int id;
  String username;
  String fullname;
  String password;

  User(
      {required this.id,
      required this.username,
      required this.fullname,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int,
      username: json["username"] as String,
      fullname: json["fullname"] as String,
      password: json["password"] as String,
    );
  }
}
