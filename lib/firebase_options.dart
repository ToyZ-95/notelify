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
    apiKey: 'AIzaSyBtxuFXzVGatpMsbPaCQTbdZXGyCDhtNv4',
    appId: '1:329270570788:web:1dd37394c9ef2811d2cdb1',
    messagingSenderId: '329270570788',
    projectId: 'notelify-6a82c',
    authDomain: 'notelify-6a82c.firebaseapp.com',
    storageBucket: 'notelify-6a82c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdw6QYVk3eweB11H3YzS8Xt_bj8JzeJy0',
    appId: '1:329270570788:android:7e60d662bfc3d6f5d2cdb1',
    messagingSenderId: '329270570788',
    projectId: 'notelify-6a82c',
    storageBucket: 'notelify-6a82c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD68VxmMkwKBwnvn7aq0C1KvrfHQrKgADI',
    appId: '1:329270570788:ios:9c0801632d10091fd2cdb1',
    messagingSenderId: '329270570788',
    projectId: 'notelify-6a82c',
    storageBucket: 'notelify-6a82c.appspot.com',
    iosClientId: '329270570788-6hgf5nd7qbi7i8kcuraq8hrs05s14u4b.apps.googleusercontent.com',
    iosBundleId: 'com.bitskraft.notelify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD68VxmMkwKBwnvn7aq0C1KvrfHQrKgADI',
    appId: '1:329270570788:ios:9c0801632d10091fd2cdb1',
    messagingSenderId: '329270570788',
    projectId: 'notelify-6a82c',
    storageBucket: 'notelify-6a82c.appspot.com',
    iosClientId: '329270570788-6hgf5nd7qbi7i8kcuraq8hrs05s14u4b.apps.googleusercontent.com',
    iosBundleId: 'com.bitskraft.notelify',
  );
}