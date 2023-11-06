// To parse this JSON data, do
//
//     final stationTrips = stationTripsFromJson(jsonString);

import 'dart:convert';

StationTrips stationTripsFromJson(String str) => StationTrips.fromJson(json.decode(str));

String stationTripsToJson(StationTrips data) => json.encode(data.toJson());

class StationTrips {
  String id;
  String tripId;
  String stationId;
  DateTime arrived;
  TripData tripData;
  StationData stationData;

  StationTrips({
    required this.id,
    required this.tripId,
    required this.stationId,
    required this.arrived,
    required this.tripData,
    required this.stationData,
  });

  factory StationTrips.fromJson(Map<String, dynamic> json) => StationTrips(
    id: json["id"],
    tripId: json["tripID"],
    stationId: json["stationID"],
    arrived: DateTime.parse(json["arrived"]),
    tripData: TripData.fromJson(json["tripData"]),
    stationData: StationData.fromJson(json["stationData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tripID": tripId,
    "stationID": stationId,
    "arrived": arrived.toIso8601String(),
    "tripData": tripData.toJson(),
    "stationData": stationData.toJson(),
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

class TripData {
  String id;
  String tripName;
  DateTime tripStartTime;
  DateTime tripEndTime;
  String routeId;
  RouteData routeData;

  TripData({
    required this.id,
    required this.tripName,
    required this.tripStartTime,
    required this.tripEndTime,
    required this.routeId,
    required this.routeData,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
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
