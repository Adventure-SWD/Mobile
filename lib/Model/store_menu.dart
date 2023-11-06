// To parse this JSON data, do
//
//     final storeMenus = storeMenusFromJson(jsonString);

import 'dart:convert';

StoreMenus storeMenusFromJson(String str) => StoreMenus.fromJson(json.decode(str));

String storeMenusToJson(StoreMenus data) => json.encode(data.toJson());

class StoreMenus {
  String id;
  String storeId;
  String menuId;
  String applyDate;
  bool priority;
  DateTime create;
  StoreData storeData;
  MenuData menuData;

  StoreMenus({
    required this.id,
    required this.storeId,
    required this.menuId,
    required this.applyDate,
    required this.priority,
    required this.create,
    required this.storeData,
    required this.menuData,
  });

  factory StoreMenus.fromJson(Map<String, dynamic> json) => StoreMenus(
    id: json["id"],
    storeId: json["storeId"],
    menuId: json["menuId"],
    applyDate: json["applyDate"],
    priority: json["priority"],
    create: DateTime.parse(json["create"]),
    storeData: StoreData.fromJson(json["storeData"]),
    menuData: MenuData.fromJson(json["menuData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeId": storeId,
    "menuId": menuId,
    "applyDate": applyDate,
    "priority": priority,
    "create": create.toIso8601String(),
    "storeData": storeData.toJson(),
    "menuData": menuData.toJson(),
  };
}

class MenuData {
  String id;
  String menuName;
  String startTimeService;
  String endTimeService;
  DateTime create;

  MenuData({
    required this.id,
    required this.menuName,
    required this.startTimeService,
    required this.endTimeService,
    required this.create,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
    id: json["id"],
    menuName: json["menuName"],
    startTimeService: json["startTimeService"],
    endTimeService: json["endTimeService"],
    create: DateTime.parse(json["create"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuName": menuName,
    "startTimeService": startTimeService,
    "endTimeService": endTimeService,
    "create": create.toIso8601String(),
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
