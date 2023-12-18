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
    apiKey: 'AIzaSyBLB57SYNs_Ie2uRVvFYtcrBHTKmKVitWk',
    appId: '1:460371142049:web:01b557142135ae7a0557e0',
    messagingSenderId: '460371142049',
    projectId: 'festumapp',
    authDomain: 'festumapp.firebaseapp.com',
    databaseURL: 'https://festumapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'festumapp.appspot.com',
    measurementId: 'G-5W6BSS28T5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLB57SYNs_Ie2uRVvFYtcrBHTKmKVitWk',
    appId: '1:460371142049:android:01b557142135ae7a0557e0',
    messagingSenderId: '460371142049',
    projectId: 'festumapp',
    databaseURL: 'https://festumapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'festumapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLB57SYNs_Ie2uRVvFYtcrBHTKmKVitWk',
    appId: '1:460371142049:ios:01b557142135ae7a0557e0',
    messagingSenderId: '460371142049',
    projectId: 'festumapp',
    databaseURL: 'https://festumapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'festumapp.appspot.com',
    // androidClientId: 'YOUR_ANDROID_CLIENT_ID',
    // iosClientId: 'YOUR_IOS_CLIENT_ID',
    // iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLB57SYNs_Ie2uRVvFYtcrBHTKmKVitWk',
    appId: '1:460371142049:ios:01b557142135ae7a0557e0',
    messagingSenderId: '460371142049',
    projectId: 'festumapp',
    databaseURL: 'https://festumapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'festumapp.appspot.com',
    // androidClientId: 'YOUR_ANDROID_CLIENT_ID',
    // iosClientId: 'YOUR_IOS_CLIENT_ID',
    // iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );
}
