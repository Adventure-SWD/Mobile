// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  String customerId;
  String roleId;
  RoleData roleData;
  CustomerData customerData;

  Customer({
    required this.customerId,
    required this.roleId,
    required this.roleData,
    required this.customerData,
  });

  Customer.empty()
      : customerId = '',
        roleId = '',
        roleData = RoleData.empty(),
        customerData = CustomerData.empty();

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json["customerId"],
    roleId: json["roleId"],
    roleData: RoleData.fromJson(json["roleData"]),
    customerData: CustomerData.fromJson(json["customerData"]),
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "roleId": roleId,
    "roleData": roleData.toJson(),
    "customerData": customerData.toJson(),
  };
}

class CustomerData {
  String id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  dynamic wallet;
  String address;
  DateTime birthday;
  dynamic created;

  CustomerData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.wallet,
    required this.address,
    required this.birthday,
    required this.created,
  });

  CustomerData.empty() :
        id = '',
        email = '',
        firstName = '',
        lastName = '',
        phoneNumber = '',
        wallet = null,
        address = '',
        birthday = DateTime.now(),
        created = null;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    wallet: json["wallet"],
    address: json["address"],
    birthday: DateTime.parse(json["birthday"]),
    created: json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "wallet": wallet,
    "address": address,
    "birthday": birthday.toIso8601String(),
    "created": created,
  };
}

class RoleData {
  String id;
  String name;

  RoleData({
    required this.id,
    required this.name,
  });

  RoleData.empty() : id = '', name = '';

  factory RoleData.fromJson(Map<String, dynamic> json) => RoleData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
