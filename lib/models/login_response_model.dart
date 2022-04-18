import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.createAt,
    required this.orders,
    required this.payments,
    required this.token,
  });
  late final int id;
  late final String ? fullName;
  late final String email;
  late final String createAt;
  late final List<dynamic> orders;
  late final List<dynamic> payments;
  late final String token;
  
  LoginResponseModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    createAt = json['createAt'];
    orders = List.castFrom<dynamic, dynamic>(json['orders']);
    payments = List.castFrom<dynamic, dynamic>(json['payments']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['createAt'] = createAt;
    _data['orders'] = orders;
    _data['payments'] = payments;
    _data['token'] = token;
    return _data;
  }
}