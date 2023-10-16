import 'package:flutter/material.dart';

class RouteSelectPage extends StatefulWidget{
  static const routeName = '/routeSelect-page';
  const RouteSelectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RouteSelectPage();
}

class _RouteSelectPage extends State<RouteSelectPage> {

  String? _selectedRoute;
  final List<String> _route = ['Tuyến số 1', 'Tuyến số 2', 'Tuyến số 3'];

  String? _selectedTime;
  final List<String> _time = ['6:00 AM', '6:15 AM', '6:30 AM'];

  String? _selectedStation;
  final List<String> _station = ['Ga số 1', 'Ga số 2', 'Ga số 3'];

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
                Container(
                    width: 600,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: _dropDownRoute(underline: Container())),
                _title("Chọn thời gian"),
                Container(
                    width: 700,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: _dropDownTime(underline: Container())),
                _title("Chọn điểm đến"),
                Container(
                    width: 700,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: _dropDownStation(underline: Container())),
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
          hint: Text("Chọn tuyến đường", style: hintStyle),
          items: _route
              .map((route) =>
              DropdownMenuItem<String>(value: route, child: Text(route)))
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
          items: _station
              .map((station) =>
              DropdownMenuItem<String>(value: station, child: Text(station)))
              .toList());
}