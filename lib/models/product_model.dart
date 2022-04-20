
import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final int category;
  final int price;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
required this.category,
    required this.price,
    required this.imageUrl,
  });
}
