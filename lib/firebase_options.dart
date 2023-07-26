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
    apiKey: 'AIzaSyDt3Gz0qPwNuX3--n6kZqH3MJ25hbyLuVk',
    appId: '1:310875191053:web:0adb17845232124250e244',
    messagingSenderId: '310875191053',
    projectId: 'todo-cc64e',
    authDomain: 'todo-cc64e.firebaseapp.com',
    storageBucket: 'todo-cc64e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsV7ogVgdTuxsWcmngw7e51A_Tk05AZUk',
    appId: '1:310875191053:android:51cd868e5ca36ab450e244',
    messagingSenderId: '310875191053',
    projectId: 'todo-cc64e',
    storageBucket: 'todo-cc64e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdPrfCmqOPpoRZKtPOSIr8TPml7Q6F90w',
    appId: '1:310875191053:ios:09efab4a8ef374a950e244',
    messagingSenderId: '310875191053',
    projectId: 'todo-cc64e',
    storageBucket: 'todo-cc64e.appspot.com',
    iosClientId:
        '310875191053-pnel9amod3uj4nsbivjhfdr6pd7h7its.apps.googleusercontent.com',
    iosBundleId: 'com.example.myProject1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdPrfCmqOPpoRZKtPOSIr8TPml7Q6F90w',
    appId: '1:310875191053:ios:acfaf9624978035a50e244',
    messagingSenderId: '310875191053',
    projectId: 'todo-cc64e',
    storageBucket: 'todo-cc64e.appspot.com',
    iosClientId:
        '310875191053-fvfmsoj121rbd4k1erjqhddjdtv9uh73.apps.googleusercontent.com',
    iosBundleId: 'com.example.myProject1.RunnerTests',
  );
}