// To parse this JSON data, do
//
//     final District = DistrictFromJson(jsonString);

import 'dart:convert';

District districtFromJson(String str) => District.fromJson(json.decode(str));

String districtToJson(District data) => json.encode(data.toJson());

class District {
  District({
    required this.id,
    required this.idProvinsi,
    required this.name,
    required this.divisionId
  });

  String id;
  String idProvinsi;
  String name;
  String divisionId;

  factory District.fromJson(Map<String, dynamic> json) => District(
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
