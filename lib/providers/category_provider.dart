import 'dart:convert';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  String image0 =
      'https://cdn-icons.flaticon.com/png/128/2084/premium/2084853.png?token=exp=1650197539~hmac=b45b32b78fb9a12b707c986ce0fced7f';
  String image1 =
      'https://cdn-icons.flaticon.com/png/128/2892/premium/2892338.png?token=exp=1650197662~hmac=349ded4d41d0261e8c1041a39bac68f8';
  String image2 =
      'https://cdn-icons.flaticon.com/png/128/2153/premium/2153786.png?token=exp=1650197726~hmac=f846a0c2ee91098179ff33d909f0d569';
  String image3 = 'https://cdn-icons-png.flaticon.com/128/1670/1670066.png';
  String image4 = 'https://cdn-icons-png.flaticon.com/128/2548/2548747.png';

  List<CategoryModel> get categories {
    return [..._categories];
  }

  Future<void> getCategories() async {
    print(_categories);
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
      print(e.toString());
      rethrow;
    }
  }
}
