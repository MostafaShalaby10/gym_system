import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    print("title : ${message.notification?.title}");
    print("body : ${message.notification?.body}");
    print("data : ${message.data}");
  }
}

class FirebaseNotification {
  final _firebaseMessage = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessage.requestPermission();
    final deviceToken = await _firebaseMessage.getToken();
    if (kDebugMode) {
      print("token is $deviceToken");
    }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print("onMessage send successfully");
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (kDebugMode) {
        print("onMessageOpenedApp send successfully");
      }
    });
  }
}
