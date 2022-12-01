class Thana {
  bool? success;
  String? messageEn;
  String? messageBn;
  List<Data>? data;

  Thana({this.success, this.messageEn, this.messageBn, this.data});

  Thana.fromJson(Map<String, dynamic> json) {
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
  String? thanaName;
  int? districtId;

  Data({this.id, this.thanaName, this.districtId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thanaName = json['thanaName'];
    districtId = json['districtId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thanaName'] = this.thanaName;
    data['districtId'] = this.districtId;
    return data;
  }
}