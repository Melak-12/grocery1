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
    apiKey: 'AIzaSyB8VSBRl98eFC70yvkMF7hoz2vX4sKKZ9E',
    appId: '1:276516542283:web:377a203c1d8699d9e23ace',
    messagingSenderId: '276516542283',
    projectId: 'updated-grocery',
    authDomain: 'updated-grocery.firebaseapp.com',
    storageBucket: 'updated-grocery.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmo-571gARWiPEiTpykRe8OZ6vGghyUmY',
    appId: '1:276516542283:android:972bd35739ed394ee23ace',
    messagingSenderId: '276516542283',
    projectId: 'updated-grocery',
    storageBucket: 'updated-grocery.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVwfyHJvSMZ553QNfY41eIn2r67MUaWZI',
    appId: '1:276516542283:ios:81fa5aa35aa1fe1be23ace',
    messagingSenderId: '276516542283',
    projectId: 'updated-grocery',
    storageBucket: 'updated-grocery.appspot.com',
    iosBundleId: 'com.example.grocery1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVwfyHJvSMZ553QNfY41eIn2r67MUaWZI',
    appId: '1:276516542283:ios:ab4c2b18dca2a982e23ace',
    messagingSenderId: '276516542283',
    projectId: 'updated-grocery',
    storageBucket: 'updated-grocery.appspot.com',
    iosBundleId: 'com.example.grocery1.RunnerTests',
  );
}
