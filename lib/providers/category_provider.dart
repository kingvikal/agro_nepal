import 'dart:convert';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories {
    return [..._categories];
  }

  Future<void> getCategories() async {
    var client = http.Client();
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};
    try {
      var url = Uri.http(Config.apiURL, Config.categoryAPI);
      var responseData = await client.get(
        url,
        headers: responseHeaders,
      );
      List<CategoryModel> _loadedCategories = [];
      List jsonData = jsonDecode(responseData.body);

      for (var category in jsonData) {
        _loadedCategories.add(
          CategoryModel(
            category['id'],
            category['category'],
          ),
        );
      }
      _categories = _loadedCategories;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
