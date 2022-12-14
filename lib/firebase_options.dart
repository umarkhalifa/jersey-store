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
    apiKey: 'AIzaSyAxJ4iObe24szzaWWdTwlVjUNVpTZY4B24',
    appId: '1:772911481050:web:1a731560a27370b65f65e3',
    messagingSenderId: '772911481050',
    projectId: 'jersey-bd2ed',
    authDomain: 'jersey-bd2ed.firebaseapp.com',
    storageBucket: 'jersey-bd2ed.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3XYUf3Lg3gx9jGswqFel2MyRmbNgbnB8',
    appId: '1:772911481050:android:f488d78532333bd85f65e3',
    messagingSenderId: '772911481050',
    projectId: 'jersey-bd2ed',
    storageBucket: 'jersey-bd2ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCz2jM__Y2KJqf27cWP10x8Xrq2IWbr3Fc',
    appId: '1:772911481050:ios:2d4648cea7e784f25f65e3',
    messagingSenderId: '772911481050',
    projectId: 'jersey-bd2ed',
    storageBucket: 'jersey-bd2ed.appspot.com',
    iosClientId: '772911481050-ss1e8848uu3qono8ntokd1lvj20882rc.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );
}
