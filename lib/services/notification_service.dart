
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Inisialisasi Local Notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotifications.initialize(initializationSettings);

    // 2. Minta izin notifikasi
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission: ${settings.authorizationStatus.name}',
    );

    // 3. Dapatkan FCM Token
    final token = await _messaging.getToken();

    debugPrint('=== FCM Token: $token ===');

    // 4. Dengarkan pesan ketika aplikasi terbuka
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('=== NOTIFIKASI DITERIMA ===');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');

      // 5. Tampilkan notifikasi lokal
      if (message.notification != null) {
        _localNotifications.show(
          DateTime.now().millisecondsSinceEpoch.remainder(100000),
          message.notification!.title,
          message.notification!.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'kosfinder_channel',
              'KosFinder Notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }
}
