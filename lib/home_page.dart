import 'package:flutter/material.dart';

//Screen
import 'package:metrofood/search_bar_app.dart';
import 'app_bar.dart';
import 'bottom_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-page';

  const MyHomePage({
    super.key
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SearchBarApp(),
      ),
      bottomNavigationBar: Material3BottomNav(
        
      ),
    );
  }
}
