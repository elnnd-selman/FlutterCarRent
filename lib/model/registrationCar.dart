// To parse this JSON data, do
//
//     final RegistrationCarModel = RegistrationCarModelFromJson(jsonString);

import 'dart:convert';

RegistrationCarModel RegistrationCarModelFromJson(String str) => RegistrationCarModel.fromJson(json.decode(str));

String RegistrationCarModelToJson(RegistrationCarModel data) => json.encode(data.toJson());

class RegistrationCarModel {
    RegistrationCarModel({
     required this.carId,
     required this.from,
     required this.id,
     required this.pay,
     required this.to,
     required this.userId,
     required this.accept,
    });

    String carId;
    String from;
    String id;
    String pay;
    String to;
    String userId;
    String accept;

    factory RegistrationCarModel.fromJson(Map<String, dynamic> json) => RegistrationCarModel(
        carId: json["carId"],
        from: json["from"],
        id: json["id"],
        pay: json["pay"],
        to: json["to"],
        userId: json["userId"],
        accept: json["accept"],
    );

    Map<String, dynamic> toJson() => {
        "carId": carId,
        "from": from,
        "id": id,
        "pay": pay,
        "to": to,
        "userId": userId,
        "accept": accept,
    };
}
