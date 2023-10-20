// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  String? id;
  String? storeId;
  String? stationName;
  DateTime? created;

  Station({
    this.id,
    this.storeId,
    this.stationName,
    this.created,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    id: json["id"],
    storeId: json["storeID"],
    stationName: json["stationName"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeID": storeId,
    "stationName": stationName,
    "created": created?.toIso8601String(),
  };
}
