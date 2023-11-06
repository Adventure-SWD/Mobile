// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  String id;
  String categoryId;
  String productName;
  String productDescription;
  dynamic image;
  int quantity;
  double price;
  CategoryData categoryData;

  Products({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.productDescription,
    required this.image,
    required this.price,
    required this.categoryData,
    this.quantity = 1
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    categoryId: json["categoryID"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    image: json["image"],
    price: json["price"]?.toDouble(),
    categoryData: CategoryData.fromJson(json["categoryData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryID": categoryId,
    "productName": productName,
    "productDescription": productDescription,
    "image": image,
    "price": price,
    "categoryData": categoryData.toJson(),
  };
}

class CategoryData {
  String categoryName;
  DateTime created;
  dynamic createBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDelete;
  String id;
  List<dynamic> domainEvents;

  CategoryData({
    required this.categoryName,
    required this.created,
    required this.createBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDelete,
    required this.id,
    required this.domainEvents,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    categoryName: json["categoryName"],
    created: DateTime.parse(json["created"]),
    createBy: json["createBy"],
    lastModified: json["lastModified"],
    lastModifiedBy: json["lastModifiedBy"],
    isDelete: json["isDelete"],
    id: json["id"],
    domainEvents: List<dynamic>.from(json["domainEvents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "created": created.toIso8601String(),
    "createBy": createBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDelete": isDelete,
    "id": id,
    "domainEvents": List<dynamic>.from(domainEvents.map((x) => x)),
  };
}
