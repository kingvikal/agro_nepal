import 'dart:convert';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/models/http_exception.dart';
import 'package:final_year_project/models/login_request_model.dart';
import 'package:final_year_project/models/login_response_model.dart';
import 'package:final_year_project/models/register_request_model.dart';
import 'package:final_year_project/services/shared_service.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  static var client = http.Client();
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};

    try {
      var url = Uri.http(Config.apiURL, Config.loginAPI);

      var response = await client.post(url,
          headers: responseHeaders, body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        await SharedService.setLoginDetails(loginResponseJson(response.body));
        int userId = jsonDecode(response.body)['id'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userId);
        SharedService.loggedInId = prefs.getInt('userId') as int;
        return true;
      } else {
        var jsonData = jsonDecode(response.body);
        throw HttpException(jsonData);
      }
    } catch (e) {
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') as int;

    Map<String, String> responseHeaders = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer ${loginDetails?.token}'
    };
    var url = Uri.http(Config.apiURL, 'user/$userId');
    var response = await client.get(url, headers: responseHeaders);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('rino0');
      print(responseData);
      SharedService.name = responseData['fullName'];
      print(SharedService.name);

      SharedService.city = responseData['city'];
      SharedService.email = responseData['email'];
      print('rino');
      SharedService.dateTime = responseData['createdAt'];
      print('rino');

      print('rino1');
      print(SharedService.email);
      print('rino1');

      return response.body;
    } else {
      return "";
    }
  }

  // static Future<void> getCategories() async {
  //   var client = http.Client();
  //   Map<String, String> responseHeaders = {'Content-Type': 'application/json'};
  //   try {
  //     var url = Uri.http(Config.apiURL, Config.categoryAPI);
  //     var responseData = await client.get(
  //       url,
  //       headers: responseHeaders,
  //     );
  //     print(responseData.body);
  //   } catch (e) {
  //     print('e');
  //   }
  // }

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
