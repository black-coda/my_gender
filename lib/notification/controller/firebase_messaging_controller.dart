import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseMsgProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});