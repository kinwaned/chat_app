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
    apiKey: 'AIzaSyBOMPdmHGjlf0tQnbOLUSblDz9VRMGvTfw',
    appId: '1:751390240162:web:677a87cb66a1b49407d6fb',
    messagingSenderId: '751390240162',
    projectId: 'chat-app-f9b63',
    authDomain: 'chat-app-f9b63.firebaseapp.com',
    storageBucket: 'chat-app-f9b63.appspot.com',
    measurementId: 'G-GD5MYG7QC8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDa0svhPkQONqEtSTGe9_OFz-xAftgpJbg',
    appId: '1:751390240162:android:98a3024776dbd35507d6fb',
    messagingSenderId: '751390240162',
    projectId: 'chat-app-f9b63',
    storageBucket: 'chat-app-f9b63.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYOcIUpdA4ciGaFdGRC3rAn90RkIT4GJk',
    appId: '1:751390240162:ios:25429319a8b2cf9b07d6fb',
    messagingSenderId: '751390240162',
    projectId: 'chat-app-f9b63',
    storageBucket: 'chat-app-f9b63.appspot.com',
    iosClientId: '751390240162-00ecl4cmb3tq6hl0qttfsjsrvkkg7go4.apps.googleusercontent.com',
    iosBundleId: 'com.example.elearningApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYOcIUpdA4ciGaFdGRC3rAn90RkIT4GJk',
    appId: '1:751390240162:ios:25429319a8b2cf9b07d6fb',
    messagingSenderId: '751390240162',
    projectId: 'chat-app-f9b63',
    storageBucket: 'chat-app-f9b63.appspot.com',
    iosClientId: '751390240162-00ecl4cmb3tq6hl0qttfsjsrvkkg7go4.apps.googleusercontent.com',
    iosBundleId: 'com.example.elearningApp',
  );
}
