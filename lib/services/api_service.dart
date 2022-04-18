import 'dart:convert';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/models/category_response_model.dart';
import 'package:final_year_project/models/http_exception.dart';
import 'package:final_year_project/models/login_request_model.dart';
import 'package:final_year_project/models/login_response_model.dart';
import 'package:final_year_project/models/register_request_model.dart';
import 'package:final_year_project/models/register_response_model.dart';
import 'package:final_year_project/services/shared_service.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};

    try {
      print('try');
      var url = Uri.http(Config.apiURL, Config.loginAPI);

      var response = await client.post(url,
          headers: responseHeaders, body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        await SharedService.setLoginDetails(loginResponseJson(response.body));
        print('rino');
        return true;
      } else {
        print('here');
        var jsonData = jsonDecode(response.body);
        throw HttpException(jsonData);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<void> register(RegisterRequestModel model) async {
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};
    try {
      var url = Uri.http(Config.apiURL, Config.registerAPI);
      var response = await client.post(url,
          headers: responseHeaders, body: jsonEncode(model.toJson()));
      if (response.statusCode == 200) {
      } else {
        var jsonData = jsonDecode(response.body);
        throw HttpException(jsonData["message"][0]);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> responseHeaders = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer ${loginDetails?.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);
    var response = await client.get(url, headers: responseHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<void> getCategories() async {
    var client = http.Client();
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};
    try {
      print('rino');
      var url = Uri.http(Config.apiURL, Config.categoryAPI);
      var responseData = await client.get(
        url,
        headers: responseHeaders,
      );
      print(responseData.body);
    } catch (e) {
      print('e');
    }
  }

  // static Future<List<CategoryResponseModel>?> category(
  //     CategoryResponseModel model) async {
  //   Map<String, String> responseHeaders = {'Content-Type': 'application/json'};

  //   var url = Uri.http(Config.apiURL, Config.categoryAPI);
  //   var response = await client.get(
  //     url,
  //     headers: responseHeaders,
  //   );
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);

  //     return categoryResponseModelFromJson(data["categoryName"]);
  //   } else {
  //     return null;
  //   }
  // }
}
