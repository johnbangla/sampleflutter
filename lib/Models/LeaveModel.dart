// To parse this JSON data, do
//
//     final LeaveModel = LeaveModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LeaveModel> LeaveModelFromJson(String str) => List<LeaveModel>.from(json.decode(str).map((x) => LeaveModel.fromJson(x)));

// String LeaveModelToJson(List<LeaveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String LeaveModelToJson(LeaveModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class LeaveModel {
    LeaveModel({
        required this.id,
        required this.leave_type,
        required this.leave_fromDate,
        required this.leave_toDate,
        required this.leave_totalDuration,
        required this.leave_reasonForLeave,
        required this.leave_addressAll

    });

    int id;
    String leave_type;
    String leave_fromDate;
    String leave_toDate;
    String leave_totalDuration;
    String leave_reasonForLeave;
    String leave_addressAll;


    factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        id: json["id"] ,
        leave_type: json["leave_type"] ,
        leave_fromDate: json["leave_fromDate"] ,
        leave_toDate: json["leave_toDate"],
        leave_totalDuration: json["leave_totalDuration"],
        leave_reasonForLeave: json["leave_reasonForLeave"],
        leave_addressAll: json["leave_addressAll"]
   
    );

    Map<String, dynamic> toJson() => {
   
        "leave_type": leave_type ,
        "leave_fromDate": leave_fromDate ,
        "leave_toDate": leave_toDate,
        "leave_totalDuration": leave_totalDuration ,
        "leave_reasonForLeave": leave_reasonForLeave ,
        "leave_addressAll": leave_addressAll 
   
    };
}
