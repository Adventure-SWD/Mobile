import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrofood/notification_page.dart';
import 'package:metrofood/profile_page.dart';
import 'package:metrofood/settingPage.dart';

//imports firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//screens
import './home_page.dart';
import './login_page.dart';
import './regis_page.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ideal time to init
  await FirebaseAuth.instance.useAuthEmulator('mobile-project-ffb9d.firebaseapp.com', 9099);
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if(user == null) {
      print('User is currently signed out!');
    } else {
      print('User signed in!');
    }
  });
  // FirebaseAuth.instance
  //     .idTokenChanges()
  //     .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
  // FirebaseAuth.instance
  //     .userChanges()
  //     .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
  runApp(const MyApp());
}

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
  bool _showAppBar = true;
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
      appBar: _showAppBar ? AppBar(
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
      ) : null,

      body: screen[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        // định dạng Footer
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,

        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 3) {
              _showAppBar = false;
            } else {
              _showAppBar = true;
            }
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
