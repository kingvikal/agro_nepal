import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.fullName,
    required this.password,
    required this.email,
    required this.id,
    required this.createAt,
    required this.token,
  });
  late final String? fullName;
  late final String? password;
  late final String? email;
  late final int? id;
  late final String? createAt;
  late final String? token;
  
  RegisterResponseModel.fromJson(Map<String, dynamic> json){
    fullName = json['fullName'];
    password = json['password'];
    email = json['email'];
    id = json['id'];
    createAt = json['createAt'];
    token = json['token'];
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullName'] = fullName;
    _data['password'] = password;
    _data['email'] = email;
    _data['id'] = id;
    _data['createAt'] = createAt;
    _data['token'] = token;
    return _data;
  }
}