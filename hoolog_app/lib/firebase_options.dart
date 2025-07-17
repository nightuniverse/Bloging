import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
        return windows;
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
    apiKey: 'AIzaSyD-ZcMPnW3NHls4dOTdApqyrW4hoGIaGMc',
    appId: '1:719196113379:web:1024a20104533ef07eb8d6',
    messagingSenderId: '719196113379',
    projectId: 'hoolog-blog',
    authDomain: 'hoolog-blog.firebaseapp.com',
    storageBucket: 'hoolog-blog.firebasestorage.app',
    measurementId: 'G-Q22G703PY9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-ZcMPnW3NHls4dOTdApqyrW4hoGIaGMc',
    appId: '1:719196113379:android:1024a20104533ef07eb8d6',
    messagingSenderId: '719196113379',
    projectId: 'hoolog-blog',
    storageBucket: 'hoolog-blog.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-ZcMPnW3NHls4dOTdApqyrW4hoGIaGMc',
    appId: '1:719196113379:ios:1024a20104533ef07eb8d6',
    messagingSenderId: '719196113379',
    projectId: 'hoolog-blog',
    storageBucket: 'hoolog-blog.firebasestorage.app',
    iosClientId: 'your-ios-client-id',
    iosBundleId: 'com.example.hoologApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-ZcMPnW3NHls4dOTdApqyrW4hoGIaGMc',
    appId: '1:719196113379:macos:1024a20104533ef07eb8d6',
    messagingSenderId: '719196113379',
    projectId: 'hoolog-blog',
    storageBucket: 'hoolog-blog.firebasestorage.app',
    iosClientId: 'your-macos-client-id',
    iosBundleId: 'com.example.hoologApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-ZcMPnW3NHls4dOTdApqyrW4hoGIaGMc',
    appId: '1:719196113379:windows:1024a20104533ef07eb8d6',
    messagingSenderId: '719196113379',
    projectId: 'hoolog-blog',
    storageBucket: 'hoolog-blog.firebasestorage.app',
  );
} 