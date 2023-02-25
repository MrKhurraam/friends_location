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
    apiKey: 'AIzaSyCTnaZwuumomPCU0em4IRCyOk5iIuSBrOo',
    appId: '1:835779362384:web:5e47e43e1d7b9e5d405b55',
    messagingSenderId: '835779362384',
    projectId: 'livelocation-a82f0',
    authDomain: 'livelocation-a82f0.firebaseapp.com',
    storageBucket: 'livelocation-a82f0.appspot.com',
    measurementId: 'G-JE7GE1R4MK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSk3W7isg22Z-nxWpJZDGMRXbL1aiJwMk',
    appId: '1:835779362384:android:662a658e46cd2ec0405b55',
    messagingSenderId: '835779362384',
    projectId: 'livelocation-a82f0',
    storageBucket: 'livelocation-a82f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFaRuH8yQdxYQtTiyycI2hSHD6f6bA4IU',
    appId: '1:835779362384:ios:8024e5bc7c52bbcf405b55',
    messagingSenderId: '835779362384',
    projectId: 'livelocation-a82f0',
    storageBucket: 'livelocation-a82f0.appspot.com',
    iosClientId: '835779362384-gf1k9u9lcmlrku1u5rmt96pb6vm93rks.apps.googleusercontent.com',
    iosBundleId: 'com.example.liveFriendsLocation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFaRuH8yQdxYQtTiyycI2hSHD6f6bA4IU',
    appId: '1:835779362384:ios:8024e5bc7c52bbcf405b55',
    messagingSenderId: '835779362384',
    projectId: 'livelocation-a82f0',
    storageBucket: 'livelocation-a82f0.appspot.com',
    iosClientId: '835779362384-gf1k9u9lcmlrku1u5rmt96pb6vm93rks.apps.googleusercontent.com',
    iosBundleId: 'com.example.liveFriendsLocation',
  );
}
