import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.name,
    this.body,
  });

  late String? id;
  late String? name;
  late String? body;

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json["_id"], name: json["name"], body: json["body"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "body": body};
}
