// To parse this JSON data, do
//
//     final menuProducts = menuProductsFromJson(jsonString);

import 'dart:convert';

MenuProducts menuProductsFromJson(String str) => MenuProducts.fromJson(json.decode(str));

String menuProductsToJson(MenuProducts data) => json.encode(data.toJson());

class MenuProducts {
  String id;
  String menuId;
  String productId;
  double priceOfProductBelongToTimeService;
  DateTime created;
  MenuData menuData;
  ProductData productData;
  dynamic storeData;

  MenuProducts({
    required this.id,
    required this.menuId,
    required this.productId,
    required this.priceOfProductBelongToTimeService,
    required this.created,
    required this.menuData,
    required this.productData,
    required this.storeData,
  });

  factory MenuProducts.fromJson(Map<String, dynamic> json) => MenuProducts(
    id: json["id"],
    menuId: json["menuID"],
    productId: json["productID"],
    priceOfProductBelongToTimeService: json["priceOfProductBelongToTimeService"],
    created: DateTime.parse(json["created"]),
    menuData: MenuData.fromJson(json["menuData"]),
    productData: ProductData.fromJson(json["productData"]),
    storeData: json["storeData"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuID": menuId,
    "productID": productId,
    "priceOfProductBelongToTimeService": priceOfProductBelongToTimeService,
    "created": created.toIso8601String(),
    "menuData": menuData.toJson(),
    "productData": productData.toJson(),
    "storeData": storeData,
  };
}

class MenuData {
  String id;
  String menuName;
  String startTimeService;
  String endTimeService;

  MenuData({
    required this.id,
    required this.menuName,
    required this.startTimeService,
    required this.endTimeService,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
    id: json["id"],
    menuName: json["menuName"],
    startTimeService: json["startTimeService"],
    endTimeService: json["endTimeService"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuName": menuName,
    "startTimeService": startTimeService,
    "endTimeService": endTimeService,
  };
}

class ProductData {
  String categoryId;
  String productName;
  String productDescription;
  String image;
  int price;
  DateTime created;

  ProductData({
    required this.categoryId,
    required this.productName,
    required this.productDescription,
    required this.image,
    required this.price,
    required this.created,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    categoryId: json["categoryID"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    image: json["image"],
    price: json["price"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "categoryID": categoryId,
    "productName": productName,
    "productDescription": productDescription,
    "image": image,
    "price": price,
    "created": created.toIso8601String(),
  };
}
