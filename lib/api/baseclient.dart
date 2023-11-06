import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:metrofood/Model/album.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/Model/customer.dart';
import 'package:metrofood/Model/products.dart';
import 'package:metrofood/Model/route.dart';
import 'package:metrofood/Model/station.dart';
import 'package:metrofood/Model/station_trip.dart';
import 'package:metrofood/Model/trip.dart';
import 'package:metrofood/Model/user.dart';

const String baseUrl = 'http://13.210.56.232/api/v1';

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _header = null;
    var response = await client.get(url, headers: _header);
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  Future<dynamic> post(String api) async {}
  Future<dynamic> put(String api) async {}
  Future<dynamic> delete(String api) async {}
  Future<Users> fetchLogin(String email, String password) async {
    var data = {'email': email, 'password': password};
    final response = await http.post(
        Uri.parse('${baseUrl}/auths/login'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
  Future<Customer> fetchRegister(
      String email, String password, String firstName,
      String lastName, String address, String phone) async {
    var data = {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "phone": phone
    };
    final response = await http.post(
        Uri.parse('${baseUrl}/customer/register-customer'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Customer> fetchCustomerById(String id) async {
    var data = {'id': id};
    final response = await http.get(
        Uri.parse('${baseUrl}/customers/${id}')
    );
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<Routes>> fetchRoute() async {
    final response =
        await http.get(Uri.parse('${baseUrl}/route'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Routes.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<Trips>> fetchTrip() async {
    final response =
    await http.get(Uri.parse('${baseUrl}/trips'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Trips.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<StationTrips>> fetchStationTrips() async {
    final response =
    await http.get(Uri.parse('${baseUrl}/station-trips'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => StationTrips.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Station>> fetchStation() async {
    final response = await http
        .get(Uri.parse('${baseUrl}/stations'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Station.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Categories>> fetchCategory() async {
    final response = await http
        .get(Uri.parse('${baseUrl}/categories'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Categories.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Products>> fetchProduct() async {
    final response = await http
        .get(Uri.parse('${baseUrl}/products'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Products.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Products> fetchProductById(String id) async {
    final response = await http.get(
        Uri.parse('${baseUrl}/products/${id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Products.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
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
