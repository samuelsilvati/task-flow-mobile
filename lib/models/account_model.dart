class AccountModel {
  String id = '';
  String name = '';
  String email = '';
  String password = '';

  AccountModel(this.id, this.name, this.email, this.password);
  AccountModel.update(this.name, this.password);

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> toJsonApi() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}
