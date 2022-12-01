// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);

import 'dart:convert';

District districtFromJson(String str) => District.fromJson(json.decode(str));

String districtToJson(District data) => json.encode(data.toJson());

class District {
  District({
    required this.id,
    required this.idKabupaten,
    required this.name,
  });

  String id;
  String idKabupaten;
  String name;

  factory District.fromJson(Map<String, dynamic> json) => District(
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
