// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String id;
  String userName;
  String email;
  String accessToken;
  dynamic storeId;
  String refreshToken;
  DateTime expires;

  Users({
    required this.id,
    required this.userName,
    required this.email,
    required this.accessToken,
    required this.storeId,
    required this.refreshToken,
    required this.expires,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    accessToken: json["accessToken"],
    storeId: json["storeId"],
    refreshToken: json["refreshToken"],
    expires: DateTime.parse(json["expires"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email": email,
    "accessToken": accessToken,
    "storeId": storeId,
    "refreshToken": refreshToken,
    "expires": expires.toIso8601String(),
  };
}
