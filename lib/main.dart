import 'package:flutter/material.dart';
import 'package:metrofood/notification_page.dart';
import 'package:metrofood/profile_page.dart';
import 'package:metrofood/settingPage.dart';

//screens
import './home_page.dart';
import './login_page.dart';
import './regis_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterScreen.routeName: (ctx) => const RegisterScreen(),
        HomePage.routeName: (ctx) => const HomePage(),
        MyHomePage.routeName: (ctx) => const MyHomePage(),
      },
    );
  }
}
class MyHomePage extends StatefulWidget {
  static const routeName = '/main-page';
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // khai báo biến
  int _currentIndex = 0;

  final screen = [
    const HomePage(),
    const SettingsPage(),
    const NewsFeedPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {

          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {

            },
          )
        ],
        title: const Text('Action Bar'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: screen[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        // định dạng Footer
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,

        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subway),
            label: "Subway",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
        ],
      ),
    );
  }
}
