class Leaveinfo {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  late List<Data> _data = [];

  Leaveinfo(
      {required bool success,
      required String messageEn,
      required String messageBn,
      required List<Data> data}) {
    if (success != null) {
      this._success = success;
    }
    if (messageEn != null) {
      this._messageEn = messageEn;
    }
    if (messageBn != null) {
      this._messageBn = messageBn;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  String get messageEn => _messageEn;
  set messageEn(String messageEn) => _messageEn = messageEn;
  String get messageBn => _messageBn;
  set messageBn(String messageBn) => _messageBn = messageBn;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  Leaveinfo.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _messageEn = json['messageEn'];
    _messageBn = json['messageBn'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['messageEn'] = this._messageEn;
    data['messageBn'] = this._messageBn;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String _employeeCode;
  late String _employeeName;
  late String _leaveTypeName;
  late dynamic  _eligible;
  late dynamic  _parking;
  late dynamic  _taken;
  late dynamic  _remaining;

  Data(
      {required String employeeCode,
      required String employeeName,
      required String leaveTypeName,
      required dynamic  eligible,
      required dynamic  parking,
      required dynamic  taken,
      required dynamic  remaining}) {
    if (employeeCode != null) {
      this._employeeCode = employeeCode;
    }
    if (employeeName != null) {
      this._employeeName = employeeName;
    }
    if (leaveTypeName != null) {
      this._leaveTypeName = leaveTypeName;
    }
    if (eligible != null) {
      this._eligible = eligible;
    }
    if (parking != null) {
      this._parking = parking;
    }
    if (taken != null) {
      this._taken = taken as dynamic ;
    }
    if (remaining != null) {
      this._remaining = remaining as dynamic ;
    }
  }

  String get employeeCode => _employeeCode;
  set employeeCode(String employeeCode) => _employeeCode = employeeCode;
  String get employeeName => _employeeName;
  set employeeName(String employeeName) => _employeeName = employeeName;
  String get leaveTypeName => _leaveTypeName;
  set leaveTypeName(String leaveTypeName) => _leaveTypeName = leaveTypeName;
  dynamic  get eligible => _eligible;
  set eligible(dynamic  eligible) => _eligible = eligible;
  dynamic  get parking => _parking;
  set parking(dynamic  parking) => _parking = parking;
 dynamic  get taken => _taken;
  set taken(dynamic  taken) => _taken = taken ;
  dynamic  get remaining => _remaining;
  set remaining(dynamic  remaining) => _remaining = remaining;

  Data.fromJson(Map<String, dynamic> json) {
    _employeeCode = json['employeeCode'];
    _employeeName = json['employeeName'];
    _leaveTypeName = json['leaveTypeName'];
    _eligible = json['eligible'];
    _parking = json['parking'];
    _taken = json['taken'];
    _remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeCode'] = this._employeeCode;
    data['employeeName'] = this._employeeName;
    data['leaveTypeName'] = this._leaveTypeName;
    data['eligible'] = this._eligible;
    data['parking'] = this._parking;
    data['taken'] = this._taken;
    data['remaining'] = this._remaining;
    return data;
  }
}
