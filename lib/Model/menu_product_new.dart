// To parse this JSON data, do
//
//     final menuProductNew = menuProductNewFromJson(jsonString);

import 'dart:convert';

MenuProductNew menuProductNewFromJson(String str) => MenuProductNew.fromJson(json.decode(str));

String menuProductNewToJson(MenuProductNew data) => json.encode(data.toJson());

class MenuProductNew {
  MenuData menuData;
  List<MenuProductDatum> menuProductData;

  MenuProductNew({
    required this.menuData,
    required this.menuProductData,
  });
  factory MenuProductNew.empty() {
    return MenuProductNew(
      menuData: MenuData.empty(),
      menuProductData: [],
    );
  }

  factory MenuProductNew.fromJson(Map<String, dynamic> json) => MenuProductNew(
    menuData: MenuData.fromJson(json["menuData"]),
    menuProductData: List<MenuProductDatum>.from(json["menuProductData"].map((x) => MenuProductDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "menuData": menuData.toJson(),
    "menuProductData": List<dynamic>.from(menuProductData.map((x) => x.toJson())),
  };
}

class MenuData {
  String id;
  String menuName;
  String startTimeService;
  String endTimeService;

  MenuData({
    required this.id,
    required this.menuName,
    required this.startTimeService,
    required this.endTimeService,
  });

  factory MenuData.empty() {
    return MenuData(
      id: '',
      menuName: '',
      startTimeService: '',
      endTimeService: '',
    );
  }

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
    id: json["id"],
    menuName: json["menuName"],
    startTimeService: json["startTimeService"],
    endTimeService: json["endTimeService"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuName": menuName,
    "startTimeService": startTimeService,
    "endTimeService": endTimeService,
  };
}

class MenuProductDatum {
  String id;
  String menuId;
  String productId;
  double priceOfProductBelongToTimeService;
  DateTime created;
  dynamic menuData;
  ProductData productData;
  StoreData storeData;

  MenuProductDatum({
    required this.id,
    required this.menuId,
    required this.productId,
    required this.priceOfProductBelongToTimeService,
    required this.created,
    required this.menuData,
    required this.productData,
    required this.storeData,
  });

  factory MenuProductDatum.fromJson(Map<String, dynamic> json) => MenuProductDatum(
    id: json["id"],
    menuId: json["menuID"],
    productId: json["productID"],
    priceOfProductBelongToTimeService: (json["priceOfProductBelongToTimeService"] as int).toDouble(),
    created: DateTime.parse(json["created"]),
    menuData: json["menuData"],
    productData: ProductData.fromJson(json["productData"]),
    storeData: StoreData.fromJson(json["storeData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuID": menuId,
    "productID": productId,
    "priceOfProductBelongToTimeService": priceOfProductBelongToTimeService,
    "created": created.toIso8601String(),
    "menuData": menuData,
    "productData": productData.toJson(),
    "storeData": storeData.toJson(),
  };
}

class ProductData {
  String categoryId;
  String productName;
  String productDescription;
  String image;
  int price;
  DateTime created;

  ProductData({
    required this.categoryId,
    required this.productName,
    required this.productDescription,
    required this.image,
    required this.price,
    required this.created,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    categoryId: json["categoryID"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    image: json["image"],
    price: json["price"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "categoryID": categoryId,
    "productName": productName,
    "productDescription": productDescription,
    "image": image,
    "price": price,
    "created": created.toIso8601String(),
  };
}

class StoreData {
  String id;
  StoreName storeName;
  StoreLocation storeLocation;
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
    storeName: storeNameValues.map[json["storeName"]]!,
    storeLocation: storeLocationValues.map[json["storeLocation"]]!,
    storeOpenTime: json["storeOpenTime"],
    storeCloseTime: json["storeCloseTime"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeName": storeNameValues.reverse[storeName],
    "storeLocation": storeLocationValues.reverse[storeLocation],
    "storeOpenTime": storeOpenTime,
    "storeCloseTime": storeCloseTime,
    "created": created.toIso8601String(),
  };
}

enum StoreLocation {
  SUI_TIN
}

final storeLocationValues = EnumValues({
  "Suối tiên": StoreLocation.SUI_TIN
});

enum StoreName {
  METRO_PICK_UP_5
}

final storeNameValues = EnumValues({
  "Metro PickUp 5": StoreName.METRO_PICK_UP_5
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
