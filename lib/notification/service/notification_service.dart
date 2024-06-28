import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  Future<void> init() async {
    final firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission(provisional: true);

    //! get token
    final fcmToken = await firebaseMessaging.getToken();
    log('fcmToken: $fcmToken', name: 'NotificationService');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }
  //

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log("Handling a background message: ${message.messageId}");
    log('Message data: ${message.data}');
    log('Message notification: ${message.notification?.title}');
    log('Message notification: ${message.notification?.body}');
  }


}
