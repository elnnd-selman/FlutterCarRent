import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.phoneNumber,
    required this.admin,
  });
  String phoneNumber;
  String name;
  String email;
  String id;
  int admin;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phoneNumber: json['phoneNumber'],
        name: json["name"],
        email: json["email"],
        id: json["id"],
        admin: json["admin"],
      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        "name": name,
        "email": email,
        "id": id,
        "admin": admin,
      };
}
