import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:final_year_project/models/login_response_model.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';

class SharedService {
  static int loggedInId = 0;
  static String name = '';
  static String city = '';
  static String email = '';
  static DateTime dateTime = DateTime.now();
  static Future<bool> isLoggedIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("secretKey");

    return isKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("secretKey");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("secretKey");
      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(
    LoginResponseModel model,
  ) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "secretKey",
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("secretKey");
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
