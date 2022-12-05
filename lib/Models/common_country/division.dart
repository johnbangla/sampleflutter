// To parse this JSON data, do
//
//     final Division = DivisionFromJson(jsonString);

import 'dart:convert';

Division divisionFromJson(String str) => Division.fromJson(json.decode(str));

String divisionToJson(Division data) => json.encode(data.toJson());

class Division {
  Division({
    required this.id,
    required this.name,
    required this.divisionCode,
  });

  String id;
  String name;
  String divisionCode;

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["id"],
        name: json["divisionName"],
        divisionCode: json["divisionCode"]
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "divisionName": name, "divisionCode": divisionCode};
}
