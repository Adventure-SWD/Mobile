// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  String id;
  String categoryName;

  Categories({
    required this.id,
    required this.categoryName,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
  };
}
