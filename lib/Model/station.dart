// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  StationData stationData;
  StoreData storeData;

  Station({
    required this.stationData,
    required this.storeData,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    stationData: StationData.fromJson(json["stationData"]),
    storeData: StoreData.fromJson(json["storeData"]),
  );

  Map<String, dynamic> toJson() => {
    "stationData": stationData.toJson(),
    "storeData": storeData.toJson(),
  };
}

class StationData {
  String id;
  String storeId;
  String stationName;
  DateTime created;

  StationData({
    required this.id,
    required this.storeId,
    required this.stationName,
    required this.created,
  });

  factory StationData.fromJson(Map<String, dynamic> json) => StationData(
    id: json["id"],
    storeId: json["storeID"],
    stationName: json["stationName"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeID": storeId,
    "stationName": stationName,
    "created": created.toIso8601String(),
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
