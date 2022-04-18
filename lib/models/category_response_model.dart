

import 'dart:convert';

List<CategoryResponseModel> categoryResponseModelFromJson(String str) => List<CategoryResponseModel>.from(json.decode(str).map((x) => CategoryResponseModel.fromJson(x)));

String categoryResponseModelToJson(List<CategoryResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryResponseModel {
    CategoryResponseModel({
        required this.id,
        required this.category,
    });

    int id;
    String category;

    factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
        id: json["id"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
    };
}
