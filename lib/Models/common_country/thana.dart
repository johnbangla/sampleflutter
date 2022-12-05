// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);

import 'dart:convert';

Thana thanaFromJson(String str) => Thana.fromJson(json.decode(str));

String thanaToJson(Thana data) => json.encode(data.toJson());

class Thana {
  Thana({
    required this.id,
    required this.idKabupaten,
    required this.name,
  });

  String id;
  String idKabupaten;
  String name;

  factory Thana.fromJson(Map<String, dynamic> json) => Thana(
        id: json["id"].toString(),
        idKabupaten: json["districtId"].toString(),
        name: json["thanaName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "districtId": idKabupaten,
        "thanaName": name,
      };
}
