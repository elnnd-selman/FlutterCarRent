// To parse this JSON data, do
//
//     final CardModel = CardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel(
      {required this.name,
      required this.brand,
      required this.id,
      required this.model,
      required this.about,
      required this.door,
      required this.isRegister,
      required this.is4By4,
      required this.moneyPerHour,
      required this.speed,
      required this.imageUrl});
  String id;
  String imageUrl;
  String name;
  String brand;
  String model;
  String about;
  String door;
  String isRegister;
  String is4By4;
  double moneyPerHour;
  String speed;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json['id'],
        imageUrl: json['imageUrl'],
        name: json["name"],
        brand: json["brand"],
        model: json["model"],
        about: json["about"],
        door: json["door"],
        isRegister: json["isRegister"],
        is4By4: json["is_4By4"],
        moneyPerHour: json["moneyPerHour"].toDouble(),
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "imageUrl": imageUrl,
        "name": name,
        "brand": brand,
        "model": model,
        "about": about,
        "door": door,
        "isRegister": isRegister,
        "is_4By4": is4By4,
        "moneyPerHour": moneyPerHour,
        "speed": speed,
      };
}
