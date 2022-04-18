class RegisterRequestModel {
  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.password,
    // required this.city,
    // required this.gender,
  });
  late final String? fullName;
  late final String? email;
  late final String? password;
  // late final String? city;
  // late final String? gender;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    // city = json['city'];
    // gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['password'] = password;
    // _data['city'] = city;
    // _data['gender'] = gender;

    return _data;
  }
}
