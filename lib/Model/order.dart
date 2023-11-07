// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  String orderId;
  String applicationUserId;
  String tripId;
  String storeId;
  String orderTokenQr;
  int totalPrice;
  String orderStatus;
  DateTime created;
  CustomerData customerData;
  TripData tripData;
  StoreData storeData;

  Orders({
    required this.orderId,
    required this.applicationUserId,
    required this.tripId,
    required this.storeId,
    required this.orderTokenQr,
    required this.totalPrice,
    required this.orderStatus,
    required this.created,
    required this.customerData,
    required this.tripData,
    required this.storeData,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    orderId: json["orderId"],
    applicationUserId: json["applicationUserID"],
    tripId: json["tripId"],
    storeId: json["storeId"],
    orderTokenQr: json["orderTokenQR"],
    totalPrice: json["totalPrice"],
    orderStatus: json["orderStatus"],
    created: DateTime.parse(json["created"]),
    customerData: CustomerData.fromJson(json["customerData"]),
    tripData: TripData.fromJson(json["tripData"]),
    storeData: StoreData.fromJson(json["storeData"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "applicationUserID": applicationUserId,
    "tripId": tripId,
    "storeId": storeId,
    "orderTokenQR": orderTokenQr,
    "totalPrice": totalPrice,
    "orderStatus": orderStatus,
    "created": created.toIso8601String(),
    "customerData": customerData.toJson(),
    "tripData": tripData.toJson(),
    "storeData": storeData.toJson(),
  };
}

class CustomerData {
  String id;
  String email;
  String firstName;
  String lastName;
  int wallet;
  String phoneNumber;
  String address;
  DateTime birthday;
  dynamic created;

  CustomerData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.wallet,
    required this.phoneNumber,
    required this.address,
    required this.birthday,
    required this.created,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    wallet: json["wallet"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    birthday: DateTime.parse(json["birthday"]),
    created: json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "wallet": wallet,
    "phoneNumber": phoneNumber,
    "address": address,
    "birthday": birthday.toIso8601String(),
    "created": created,
  };
}

class StoreData {
  String id;
  String storeName;
  String storeLocation;
  String storeOpenTime;
  String storeCloseTime;
  DateTime created;

  StoreData({
    required this.id,
    required this.storeName,
    required this.storeLocation,
    required this.storeOpenTime,
    required this.storeCloseTime,
    required this.created,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
    id: json["id"],
    storeName: json["storeName"],
    storeLocation: json["storeLocation"],
    storeOpenTime: json["storeOpenTime"],
    storeCloseTime: json["storeCloseTime"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeName": storeName,
    "storeLocation": storeLocation,
    "storeOpenTime": storeOpenTime,
    "storeCloseTime": storeCloseTime,
    "created": created.toIso8601String(),
  };
}

class TripData {
  String id;
  String tripName;
  dynamic routeResponse;

  TripData({
    required this.id,
    required this.tripName,
    required this.routeResponse,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
    id: json["id"],
    tripName: json["tripName"],
    routeResponse: json["routeResponse"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tripName": tripName,
    "routeResponse": routeResponse,
  };
}
