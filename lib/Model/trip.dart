// To parse this JSON data, do
//
//     final trips = tripsFromJson(jsonString);

import 'dart:convert';

Trips tripsFromJson(String str) => Trips.fromJson(json.decode(str));

String tripsToJson(Trips data) => json.encode(data.toJson());

class Trips {
  String id;
  String tripName;
  DateTime tripStartTime;
  DateTime tripEndTime;
  String routeId;
  RouteData routeData;

  Trips({
    required this.id,
    required this.tripName,
    required this.tripStartTime,
    required this.tripEndTime,
    required this.routeId,
    required this.routeData,
  });

  factory Trips.fromJson(Map<String, dynamic> json) => Trips(
    id: json["id"],
    tripName: json["tripName"],
    tripStartTime: DateTime.parse(json["tripStartTime"]),
    tripEndTime: DateTime.parse(json["tripEndTime"]),
    routeId: json["routeId"],
    routeData: RouteData.fromJson(json["routeData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tripName": tripName,
    "tripStartTime": tripStartTime.toIso8601String(),
    "tripEndTime": tripEndTime.toIso8601String(),
    "routeId": routeId,
    "routeData": routeData.toJson(),
  };
}

class RouteData {
  String id;
  String fromLocation;
  String toLocation;

  RouteData({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) => RouteData(
    id: json["id"],
    fromLocation: json["fromLocation"],
    toLocation: json["toLocation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fromLocation": fromLocation,
    "toLocation": toLocation,
  };
}
