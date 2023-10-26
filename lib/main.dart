import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:metrofood/cart_page.dart';
import 'package:metrofood/notification_page.dart';
import 'package:metrofood/profile_page.dart';
import 'package:metrofood/route_select.dart';
import 'package:metrofood/setting_page.dart';

//imports firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

//screens
import './home_page.dart';
import './login_page.dart';
import './regis_page.dart';
import './transaction_page.dart';
import './categories_page.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ideal time to init
  try {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  } catch(e) {
    print("Firebase emulator error at e");
    print(e);
  }
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug
  );
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  // UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  // FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandler(message));
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
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
      home: MainPage(),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterScreen.routeName: (ctx) => const RegisterScreen(),
        HomePage.routeName: (ctx) => const HomePage(),
        MyHomePage.routeName: (ctx) => const MyHomePage(),
        TransactionPage.routeName: (ctx) => const TransactionPage(),
        CategoriesPage.routeName: (ctx) => const CategoriesPage(),
        CartPage.routeName: (ctx) => const CartPage(),
      },
    );
  }
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<String?> getUserId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("userId");
    }
    return Scaffold(
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Kiểm tra nếu userId không null, tức là người dùng đã đăng nhập
            if (snapshot.hasData && snapshot.data != null) {
              return MyHomePage();
            } else {
              return LoginScreen();
            }
          } else {
            // Hiển thị một tiêu đề tạm thời hoặc tiêu đề loading trong quá trình kiểm tra
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // body: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return MyHomePage();
      //     } else {
      //       return LoginScreen();
      //     }
      //
      //   },
      // ),
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
    const RouteSelectPage(),
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
        fixedColor: Color(0xFFFF8552),
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
