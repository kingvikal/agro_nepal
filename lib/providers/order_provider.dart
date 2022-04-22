import 'dart:convert';

import 'package:final_year_project/config.dart';
import 'package:final_year_project/services/shared_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum PaymentStatus { unpaid, paid }

class OrderModel {
  final int quantity;
  final String paymentStatus;
  final int price;

  OrderModel({
    required this.quantity,
    required this.paymentStatus,
    required this.price,
  });
}

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> get orders {
    return [..._orders];
  }

  Future<void> getOrders() async {
    var loginDetails = await SharedService.loginDetails();
    var client = http.Client();
    Map<String, String> responseHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.token}'
    };
    try {
      var url = Uri.http(Config.apiURL, Config.ordersAPI);
      var responseData = await client.get(
        url,
        headers: responseHeaders,
      );
      List<OrderModel> _loadedOrders = [];
      List jsonData = jsonDecode(responseData.body);
      print('rino');
      print(jsonData);
      print('rino');

      for (var order in jsonData) {
        _loadedOrders.add(
          OrderModel(
            quantity: order['quantity'],
            paymentStatus: order['status'],
            price: order['price'],
          ),
        );
      }
      _orders = _loadedOrders;
      notifyListeners();
      print(_orders.length);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> addOrder(
    int price,
    PaymentStatus paymentStatus,
    int quantity,
  ) async {
    var loginDetails = await SharedService.loginDetails();
    var client = http.Client();
    Map<String, String> responseHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails?.token}'
    };
    try {
      var url = Uri.http(Config.apiURL, Config.ordersAPI);
      var responseData = await client.post(
        url,
        headers: responseHeaders,
        body: jsonEncode(
          {
            "price": price,
            "status": paymentStatus == PaymentStatus.unpaid ? 'unpaid' : 'paid',
            "quantity": quantity,
            "productId": 1,
            "userId": '${SharedService.userId}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
