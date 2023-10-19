// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDEm3ju447ylHYxz3ufIsc3k6wlWCk3U18',
    appId: '1:408679819932:web:2fef62c276e41b25509b59',
    messagingSenderId: '408679819932',
    projectId: 'metrofood-4e6ca',
    authDomain: 'metrofood-4e6ca.firebaseapp.com',
    storageBucket: 'metrofood-4e6ca.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIZOxQ5sa0dwDcm409HXrnuUg449-E7zo',
    appId: '1:408679819932:android:0fe034a1923be261509b59',
    messagingSenderId: '408679819932',
    projectId: 'metrofood-4e6ca',
    storageBucket: 'metrofood-4e6ca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARHYhpFhkRU7L-O27ngonrjvUdUfb3ugM',
    appId: '1:408679819932:ios:66e83505fc97f72d509b59',
    messagingSenderId: '408679819932',
    projectId: 'metrofood-4e6ca',
    storageBucket: 'metrofood-4e6ca.appspot.com',
    iosBundleId: 'com.example.metrofood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARHYhpFhkRU7L-O27ngonrjvUdUfb3ugM',
    appId: '1:408679819932:ios:93ac37ff77f0e729509b59',
    messagingSenderId: '408679819932',
    projectId: 'metrofood-4e6ca',
    storageBucket: 'metrofood-4e6ca.appspot.com',
    iosBundleId: 'com.example.metrofood.RunnerTests',
  );
}
