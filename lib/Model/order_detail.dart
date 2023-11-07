// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  String orderDetailId;
  int quanity;
  int price;
  String orderId;
  String productId;
  DateTime created;
  OrderData orderData;
  ProductData productData;

  OrderDetail({
    required this.orderDetailId,
    required this.quanity,
    required this.price,
    required this.orderId,
    required this.productId,
    required this.created,
    required this.orderData,
    required this.productData,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    orderDetailId: json["orderDetailId"],
    quanity: json["quanity"],
    price: json["price"],
    orderId: json["orderID"],
    productId: json["productID"],
    created: DateTime.parse(json["created"]),
    orderData: OrderData.fromJson(json["orderData"]),
    productData: ProductData.fromJson(json["productData"]),
  );

  Map<String, dynamic> toJson() => {
    "orderDetailId": orderDetailId,
    "quanity": quanity,
    "price": price,
    "orderID": orderId,
    "productID": productId,
    "created": created.toIso8601String(),
    "orderData": orderData.toJson(),
    "productData": productData.toJson(),
  };
}

class OrderData {
  String applicationUserId;
  String tripId;
  String storeId;
  int totalPrice;
  String orderTokenQr;
  DateTime created;

  OrderData({
    required this.applicationUserId,
    required this.tripId,
    required this.storeId,
    required this.totalPrice,
    required this.orderTokenQr,
    required this.created,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    applicationUserId: json["applicationUserID"],
    tripId: json["tripID"],
    storeId: json["storeID"],
    totalPrice: json["totalPrice"],
    orderTokenQr: json["orderTokenQR"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "applicationUserID": applicationUserId,
    "tripID": tripId,
    "storeID": storeId,
    "totalPrice": totalPrice,
    "orderTokenQR": orderTokenQr,
    "created": created.toIso8601String(),
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
