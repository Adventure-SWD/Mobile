import 'package:flutter/material.dart';
import 'package:metrofood/Model/album.dart';
import 'package:metrofood/Model/route.dart';
import 'package:metrofood/Model/station.dart';
import 'package:metrofood/api/baseclient.dart';

class RouteSelectPage extends StatefulWidget {
  static const routeName = '/routeSelect-page';
  const RouteSelectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RouteSelectPage();
}

class _RouteSelectPage extends State<RouteSelectPage> {
  late Future<Album> futureAlbum;
  late Future<List<Routes>> futureRoute;
  late Future<List<Station>> futureStation;
  late List<Routes> listRoute = [];
  late List<Station> listStation = [];
  String? _selectedRoute;

  String? _selectedTime;
  final List<String> _time = ['6:00 AM', '6:15 AM', '6:30 AM'];

  String? _selectedStation;
  List<String> _station = [];

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  Future<void> initializeData() async {
    try {
      futureAlbum = BaseClient().fetchAlbum();
      futureRoute = BaseClient().fetchRoute();
      futureStation = BaseClient().fetchStation();
      await futureRoute.then((value) {
        setState(() {
          listRoute = value.toList();
        });
      }).catchError((error) {});
      await futureStation.then((stations) {
        setState(() {
          listStation = stations.toList();
        });
      }).catchError((error) {});
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
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
                _title("Chọn thời gian"),
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
                    print(_station.toList());
                  },
                  child: const Text('Text'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          value: _selectedTime,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: style,
          iconEnabledColor: iconEnabledColor,
          onChanged: (String? newValue) {
            setState(() {
              _selectedTime = newValue;
            });
          },
          hint: Text("Chọn thời gian", style: hintStyle),
          items: _time
              .map((time) =>
                  DropdownMenuItem<String>(value: time, child: Text(time)))
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
            });
          },
          hint: Text("Chọn trạm tàu", style: hintStyle),
          items: listStation
              .map((station) => DropdownMenuItem<String>(
                  value: station.stationData.id,
                  child: Text(station.stationData.stationName)))
              .toList());
}
