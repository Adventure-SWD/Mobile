import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:metrofood/Model/album.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/Model/route.dart';
import 'package:metrofood/Model/station.dart';

const String baseUrl = 'http://13.210.56.232/api/v1';

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api,dynamic object) async{
    var url = Uri.parse(baseUrl + api);
    var _header = null;
    var response = await client.get(url, headers: _header);
    if(response.statusCode == 200) {
      return response.body;
    } else {

    }
  }
  Future<dynamic> post(String api) async{}
  Future<dynamic> put(String api) async{}
  Future<dynamic> delete(String api) async{}
  Future<List<Routes>> fetchRoute() async {
    final response = await http.get(Uri.parse(
        'http://13.210.56.232/api/v1/route/get-all'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Routes.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<Station>> fetchStation() async {
    final response = await http.get(Uri.parse(
        'http://13.210.56.232/api/v1/station/get-all-station'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Station.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<Categories> fetchCategory() async {
    final response = await http
        .get(Uri.parse('http://13.210.56.232/api/v1/category/get-by-id?Id=8908ea98-b421-420b-9634-03ed356bb921'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Categories.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load category');
    }
  }
  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}