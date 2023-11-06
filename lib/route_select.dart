import 'package:flutter/material.dart';
import 'package:metrofood/Model/album.dart';
import 'package:metrofood/Model/cart.dart';
import 'package:metrofood/Model/menu_product.dart';
import 'package:metrofood/Model/products.dart';
import 'package:metrofood/Model/route.dart';
import 'package:metrofood/Model/station.dart';
import 'package:metrofood/Model/station_trip.dart';
import 'package:metrofood/Model/store_menu.dart';
import 'package:metrofood/Model/trip.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:provider/provider.dart';

class RouteSelectPage extends StatefulWidget {
  static const routeName = '/routeSelect-page';
  const RouteSelectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RouteSelectPage();
}

class _RouteSelectPage extends State<RouteSelectPage> {
  late Future<Album> futureAlbum;
  late Future<List<Routes>> futureRoute;
  late Future<List<Trips>> futureTrip;
  late Future<List<Station>> futureStation;
  late Future<List<StationTrips>> futureStationTrips;
  late Future<List<StoreMenus>> futureStoreMenu;
  late Future<List<MenuProducts>> futureMenuProduct;
  late List<MenuProducts> listMenuProduct = [];
  late List<StoreMenus> listStoreMenu = [];
  late List<Routes> listRoute = [];
  late List<Trips> listTrip = [];
  late List<Station> listStation = [];
  late List<StationTrips> listStationTrips = [];
  String? _selectedRoute;
  String? _selectedTrip;
  bool isLoading = true;
  String? _selectedStation;

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  void filterTripsByRouteId(String routeId) {
    futureTrip.then((value) {
      listTrip = value.where((trip) => trip.routeId == routeId).toList();
    });
  }

  void filterStationsByTripId(String tripId) {
    futureStationTrips.then((value) {
      listStationTrips =
          value.where((station) => station.tripId == tripId).toList();
    });
  }

  Future<void> getMenuAndProductByStoreId(String id) async {
    try {
      futureStoreMenu = BaseClient().fetchStoreMenuByStoreId(id);
      await futureStoreMenu.then((value) {
        listStoreMenu = value.toList();
      });
      futureMenuProduct = BaseClient()
          .fetchMenuProductsByMenuId(listStoreMenu.firstOrNull!.menuId);
      await futureMenuProduct.then((value) {
          listMenuProduct = value.toList();
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }
  Future<Products> addProductClicked(String id) async {
    try {
      Products product = await BaseClient().fetchProductById(id);
      return product;
    } catch (error) {
      print(error);
      throw error; // Nếu có lỗi, bạn có thể ném ngoại lệ hoặc xử lý theo ý của bạn
    }
  }
  Future<void> initializeData() async {
    try {
      futureAlbum = BaseClient().fetchAlbum();
      futureRoute = BaseClient().fetchRoute();
      futureTrip = BaseClient().fetchTrip();
      futureStationTrips = BaseClient().fetchStationTrips();
      futureStation = BaseClient().fetchStation();
      await futureRoute.then((value) {
        setState(() {
          listRoute = value.toList();
        });
      }).catchError((error) {});
      await futureTrip.then((value) {
        setState(() {
          listTrip = value.toList();
        });
      });
      await futureStationTrips.then((value) {
        setState(() {
          listStationTrips = value.toList();
        });
      });
      await futureStation.then((stations) {
        setState(() {
          listStation = stations.toList();
        });
      }).catchError((error) {});
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: ListView(padding: const EdgeInsets.all(10.0), children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _title("Chọn tuyến đường"),
                  // FutureBuilder<Categories>(
                  //   future: futureCategory,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Text(
                  //           snapshot.data!.categoryName + snapshot.data!.id
                  //       );
                  //     } else if (snapshot.hasError) {
                  //       return Text('${snapshot.error}');
                  //     }
                  //     // By default, show a loading spinner.
                  //     return const CircularProgressIndicator();
                  //   },
                  // ),
                  SingleChildScrollView(
                    child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: _dropDownRoute(underline: Container())),
                  ),
                  _title("Chọn chuyến đi"),
                  Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: _dropDownTime(underline: Container())),
                  _title("Chọn điểm đến"),
                  Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: _dropDownStation(underline: Container())),
                  ElevatedButton(
                    onPressed: () {
                      // var _response = BaseClient()
                      //     .get('/route/get-all', List<Route>)
                      //     .then((data) {
                      //   if (data != null) {
                      //     print('success $data');
                      //   } else {
                      //     print('null object');
                      //   }
                      // }).catchError((err) {
                      //   print(err);
                      // });
                      // print(_response.toString());
                      print(listMenuProduct.toString());
                    },
                    child: const Text('Text'),
                  ),
                ],
              ),
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Số cột
              crossAxisSpacing: 16, // Khoảng cách ngang giữa các cột
              mainAxisSpacing: 16, // Khoảng cách dọc giữa các hàng
            ),
            itemCount: listMenuProduct.length,
            // Số lượng phần tử trong danh sách
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                width: 150,
                height: 150,
                decoration: ShapeDecoration(
                  color: Color(0xFFFF8552),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFE6E6E6),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Text(
                      listMenuProduct[index].productData.productName,
                      // Sử dụng dữ liệu từ danh sách
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    ElevatedButton(onPressed: () {
                      Future<Products> productFuture = addProductClicked(listMenuProduct[index].productId);
                      productFuture.then((product) {
                        cartProvider.addToCart(product);
                        // Cập nhật giao diện người dùng nếu cần thiết
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sản phẩm đã được thêm vào giỏ hàng.'),
                          ),
                        );
                      }).catchError((error) {
                        print(error);
                        // Xử lý lỗi nếu có
                      });
                    }
                    , child: const Text('Thêm vào giỏ hàng'),
                    )
                  ],
                ),
              );
            },
          ),
        ]),
      );
    }
  }

  Widget _title(String val) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        val,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dropDownRoute({
    Widget? underline,
    Widget? icon,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
          value: _selectedRoute,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: style,
          iconEnabledColor: iconEnabledColor,
          onChanged: (String? newValue) {
            setState(() {
              _selectedRoute = newValue;
              if (_selectedRoute != null) {
                filterTripsByRouteId(_selectedRoute!);
                _selectedTrip = null;
                _selectedStation = null;
              }
            });
          },
          isExpanded: true,
          hint: Text("Chọn tuyến đường", style: hintStyle),
          items: listRoute
              .map((route) => DropdownMenuItem<String>(
                  value: route.id,
                  child: Text(
                    '${route.fromLocation} đến ${route.toLocation}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    // style: TextStyle(fontSize: 12),
                  )))
              .toList());

  Widget _dropDownTime({
    Widget? underline,
    Widget? icon,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
          value: _selectedTrip,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: style,
          iconEnabledColor: iconEnabledColor,
          onChanged: (String? newValue) {
            setState(() {
              _selectedTrip = newValue;
              if (_selectedTrip != null) {
                filterStationsByTripId(_selectedTrip!);
                _selectedStation = null;
              }
            });
          },
          hint: Text("Chọn chuyến đi", style: hintStyle),
          items: listTrip
              .map((trip) => DropdownMenuItem<String>(
                  value: trip.id, child: Text(trip.tripName)))
              .toList());

  Widget _dropDownStation({
    Widget? underline,
    Widget? icon,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
          value: _selectedStation,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: style,
          iconEnabledColor: iconEnabledColor,
          onChanged: (String? newValue) {
            setState(() {
              _selectedStation = newValue;
              if (_selectedStation != null) {
                getMenuAndProductByStoreId(_selectedStation!);
                isLoading = true;
              }
            });
          },
          hint: Text("Chọn trạm tàu", style: hintStyle),
          items: listStationTrips
              .map((station) => DropdownMenuItem<String>(
                  value: station.stationData.storeId,
                  child: Text(station.stationData.stationName)))
              .toList());
}
