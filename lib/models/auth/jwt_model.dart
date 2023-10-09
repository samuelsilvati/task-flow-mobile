class JwtModel {
  String name = '';
  String sub = '';
  int iat = 0;
  int exp = 0;

  JwtModel(this.name, this.sub, this.iat, this.exp);

  JwtModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sub = json['sub'];
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['sub'] = sub;
    data['iat'] = iat;
    data['exp'] = exp;
    return data;
  }
}
