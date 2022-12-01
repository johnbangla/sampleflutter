// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    required this.id,
    required this.idProvinsi,
    required this.name,
    required this.divisionId
  });

  String id;
  String idProvinsi;
  String name;
  String divisionId;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"].toString(),
        // idProvinsi: json["id_provinsi"],
        idProvinsi: json["districtCode"],
        name: json["districtName"],
        divisionId:json["divisionId"].toString()
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "districtCode": idProvinsi,
        "districtName": name,
        "divisionId":divisionId
      };
}
