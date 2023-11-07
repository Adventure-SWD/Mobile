import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:metrofood/Model/album.dart';
import 'package:metrofood/Model/category.dart';
import 'package:metrofood/Model/customer.dart';
import 'package:metrofood/Model/menu_product.dart';
import 'package:metrofood/Model/menu_product_new.dart';
import 'package:metrofood/Model/order.dart';
import 'package:metrofood/Model/products.dart';
import 'package:metrofood/Model/route.dart';
import 'package:metrofood/Model/station.dart';
import 'package:metrofood/Model/station_trip.dart';
import 'package:metrofood/Model/store_menu.dart';
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
  Future<MenuProductNew> fetchMenuProductsNewByMenuId(String id) async {
    final response = await http
        .get(Uri.parse('${baseUrl}/menu-products/stations/${id}'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MenuProductNew.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data ${response.statusCode}');
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
  Future<List<MenuProducts>> fetchMenuProducts() async {
    final response = await http
        .get(Uri.parse('${baseUrl}/menu-products'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => MenuProducts.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<MenuProducts>> fetchMenuProductsByMenuId(String id) async {
    final response = await http
        .get(Uri.parse('${baseUrl}/menu-products/stations/${id}'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => MenuProducts.fromJson(e)).toList();
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
  Future<List<StoreMenus>> fetchStoreMenuByStoreId(String id) async {
    final response = await http.get(
        Uri.parse('${baseUrl}/store-menus/${id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List result = json.decode(response.body);
      return result.map((e) => StoreMenus.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }
  Future<List<Orders>> fetchOrderByUserId(String id) async {
    final response = await http.get(
        Uri.parse('${baseUrl}/orders/customers/${id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List result = json.decode(response.body);
      return result.map((e) => Orders.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load product');
    }
  }

  Future<List<Products>> fetchProductByCateId(String categoryId) async {
    final response = await http.get(
        Uri.parse('${baseUrl}/products?categoryID=$categoryId'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List result = json.decode(response.body);
      return result.map((e) => Products.fromJson(e)).toList();
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
  Future<http.Response> createOrder({
    required String applicationUserID,
    required String tripId,
    required String storeId,
    required List<MenuProducts> products,
  }) async {
    final apiUrl = '${baseUrl}/orders';
    final headers = <String, String>{
      'Content-Type': 'application/json',
      // Các tiêu đề khác nếu cần
    };

    final orderData = {
      'applicationUserID': applicationUserID,
      'tripId': tripId,
      'storeId': storeId,
      'products': products
          .map((product) => {
        'productId': product.productId,
        'quantity': product.quantity,
        'priceOfProductBelongToTimeService': product.priceOfProductBelongToTimeService,
      })
          .toList(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      // Xử lý kết quả thành công
      print('Đã tạo đơn hàng thành công');
      return response;
    } else {
      // Xử lý lỗi hoặc trạng thái khác
      print('Lỗi khi tạo đơn hàng: ${response.statusCode}');
      print('Nội dung lỗi: ${response.body}');
      return response;
    }
  }
}
