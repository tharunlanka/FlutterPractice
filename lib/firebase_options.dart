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
    apiKey: 'AIzaSyDYxBf9B7893m-uuAjRbEt0VKJiN1Dg8vs',
    appId: '1:868842852239:web:839658e2cb83aaa54e85fa',
    messagingSenderId: '868842852239',
    projectId: 'flutter-5bc78',
    authDomain: 'flutter-5bc78.firebaseapp.com',
    databaseURL: 'https://flutter-5bc78-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-5bc78.appspot.com',
    measurementId: 'G-TPDY902R3R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmOReTJSFJvKbOsRpjQ9cFMvqs_0XhxJY',
    appId: '1:868842852239:android:eaf83a885a53779d4e85fa',
    messagingSenderId: '868842852239',
    projectId: 'flutter-5bc78',
    databaseURL: 'https://flutter-5bc78-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-5bc78.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvOY5-2KIJRHKIGCVQACdXdWsXW-_wqx4',
    appId: '1:868842852239:ios:e9f415cbcf59c49b4e85fa',
    messagingSenderId: '868842852239',
    projectId: 'flutter-5bc78',
    databaseURL: 'https://flutter-5bc78-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-5bc78.appspot.com',
    iosClientId: '868842852239-0h6li59puc0o065tvm5o1f9tbfv9u71i.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterPractice',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvOY5-2KIJRHKIGCVQACdXdWsXW-_wqx4',
    appId: '1:868842852239:ios:e9f415cbcf59c49b4e85fa',
    messagingSenderId: '868842852239',
    projectId: 'flutter-5bc78',
    databaseURL: 'https://flutter-5bc78-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-5bc78.appspot.com',
    iosClientId: '868842852239-0h6li59puc0o065tvm5o1f9tbfv9u71i.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterPractice',
  );
}