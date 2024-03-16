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
    apiKey: 'AIzaSyCRZWL8FAevd-Oxw8y4_y27u7zFxkY2IbA',
    appId: '1:756037822938:web:c25de6880b008c30a978e3',
    messagingSenderId: '756037822938',
    projectId: 'bocarservice-8ea17',
    authDomain: 'bocarservice-8ea17.firebaseapp.com',
    storageBucket: 'bocarservice-8ea17.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCioinThsNx0mP3ODT2M5olefgu2iXmglk',
    appId: '1:756037822938:android:700d4b0d16020abca978e3',
    messagingSenderId: '756037822938',
    projectId: 'bocarservice-8ea17',
    storageBucket: 'bocarservice-8ea17.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnKac-yTcyvwNRD189FBETyqk8afgdZmc',
    appId: '1:756037822938:ios:58cf79584e2bb6a2a978e3',
    messagingSenderId: '756037822938',
    projectId: 'bocarservice-8ea17',
    storageBucket: 'bocarservice-8ea17.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnKac-yTcyvwNRD189FBETyqk8afgdZmc',
    appId: '1:756037822938:ios:2d43e4533ddff436a978e3',
    messagingSenderId: '756037822938',
    projectId: 'bocarservice-8ea17',
    storageBucket: 'bocarservice-8ea17.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
