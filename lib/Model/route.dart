// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

Routes routesFromJson(String str) => Routes.fromJson(json.decode(str));

String routesToJson(Routes data) => json.encode(data.toJson());

class Routes {
  String id;
  String fromLocation;
  String toLocation;

  Routes({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
  });

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
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
