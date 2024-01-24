// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;
  String? serverAuthCode;

  UserData({
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
    this.serverAuthCode,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    displayName: json["displayName"],
    email: json["email"],
    id: json["id"],
    photoUrl: json["photoUrl"],
    serverAuthCode: json["serverAuthCode"],
  );

  Map<String, dynamic> toJson() => {
    "displayName": displayName,
    "email": email,
    "id": id,
    "photoUrl": photoUrl,
    "serverAuthCode": serverAuthCode,
  };
}

UserData userFromJson(String str) => UserData.fromJson(json.decode(str));

String userToJson(UserData data) => json.encode(data.toJson());

class User {
  String? username;
  String? email;
  int? id;
  String? photoUrl;
  String? userId;

  User({
    this.username,
    this.email,
    this.id,
    this.photoUrl,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    email: json["email"],
    id: json["id"],
    photoUrl: json["photoUrl"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "displayName": username,
    "email": email,
    "id": id,
    "photoUrl": photoUrl,
    "serverAuthCode": userId,
  };
}
