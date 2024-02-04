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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCK8BlDpORiNL6asK9UrZ-F5NysoryxV8M',
    appId: '1:302157280181:web:80d48a890bdacf404ddffc',
    messagingSenderId: '302157280181',
    projectId: 'flutterserious',
    authDomain: 'flutterserious.firebaseapp.com',
    storageBucket: 'flutterserious.appspot.com',
    measurementId: 'G-WQ38ZQD9X4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCn3_lYuz5PG2jPa2xbRnCgRXL4QQhq-ks',
    appId: '1:302157280181:android:bee4b29ed9b8a1bf4ddffc',
    messagingSenderId: '302157280181',
    projectId: 'flutterserious',
    storageBucket: 'flutterserious.appspot.com',
  );
}
