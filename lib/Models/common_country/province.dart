// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  Province({
    required this.id,
    required this.name,
    required this.divisionCode,
  });

  String id;
  String name;
  String divisionCode;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["divisionName"],
        divisionCode: json["divisionCode"]
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "divisionName": name, "divisionCode": divisionCode};
}
