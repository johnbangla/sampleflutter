class District {
  bool? success;
  String? messageEn;
  String? messageBn;
  List<Data>? data;

  District({this.success, this.messageEn, this.messageBn, this.data});

  District.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messageEn = json['messageEn'];
    messageBn = json['messageBn'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messageEn'] = this.messageEn;
    data['messageBn'] = this.messageBn;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? districtName;
  String? districtCode;
  int? divisionId;

  Data({this.id, this.districtName, this.districtCode, this.divisionId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['districtName'];
    districtCode = json['districtCode'];
    divisionId = json['divisionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['districtName'] = this.districtName;
    data['districtCode'] = this.districtCode;
    data['divisionId'] = this.divisionId;
    return data;
  }
}
