import 'dart:convert';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products {
    return [..._products];
  }

  List<ProductModel> _shuffledProducts = [];

  List<ProductModel> get shuffledProducts {
    return [..._shuffledProducts];
  }

  Future<void> getAllProducts() async {
    var client = http.Client();
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};
    try {
      var url = Uri.http(Config.apiURL, Config.productsAPI);
      var responseData = await client.get(
        url,
        headers: responseHeaders,
      );
      List<ProductModel> _loadedProducts = [];
      List jsonData = jsonDecode(responseData.body);

      for (var product in jsonData) {
        _loadedProducts.add(ProductModel(
            id: product['id'],
            title: product['title'],
            description: product['description'],
            // category: product['category'],
            price: product['price'],
            imageUrl: product['image']));
      }
      _products = _loadedProducts;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getShuffledProducts() async {
    var client = http.Client();
    Map<String, String> responseHeaders = {'Content-Type': 'application/json'};
    try {
      var url = Uri.http(Config.apiURL, Config.productsAPI);
      var responseData = await client.get(
        url,
        headers: responseHeaders,
      );
      List<ProductModel> _loadedProducts = [];
      List jsonData = jsonDecode(responseData.body);

      for (var product in jsonData) {
        _loadedProducts.add(ProductModel(
            id: product['id'],
            title: product['title'],
            description: product['description'],
            // category: product['category'],
            price: product['price'],
            imageUrl: product['image']));
      }

      _shuffledProducts = _loadedProducts;
      _shuffledProducts.shuffle();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
