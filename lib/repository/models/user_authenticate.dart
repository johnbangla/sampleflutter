class UserAthenticate {
  late String _token;
  late Null _refreshToken;

  UserAthenticate({required String token, Null refreshToken}) {
    this._token = token;
    this._refreshToken = refreshToken;
  }

  String get token => _token;
  set token(String token) => _token = token;
  Null get refreshToken => _refreshToken;
  set refreshToken(Null refreshToken) => _refreshToken = refreshToken;

  UserAthenticate.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    data['refreshToken'] = this._refreshToken;
    return data;
  }
}