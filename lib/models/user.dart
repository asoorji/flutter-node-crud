import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.name,
    this.body,
  });

  late String? name;
  late String? body;

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json["name"], body: json["body"]);

  Map<String, dynamic> toJson() => {"name": name, "body": body};
}
