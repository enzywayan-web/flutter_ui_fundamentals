
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

// ==========================================
// PRAKTIK 10: BACKGROUND NOTIFICATION HANDLER
// Fungsi harus berada di luar class
// ==========================================

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint(
    '[BACKGROUND] ${message.notification?.title}',
  );

  debugPrint(
    '[BACKGROUND] ${message.notification?.body}',
  );
}

// ==========================================
// NOTIFICATION SERVICE
// ==========================================

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Inisialisasi Local Notification
    const AndroidInitializationSettings
        initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotifications.initialize(
      initializationSettings,
    );

    // 2. Meminta izin notifikasi
    await requestPermission();

    // 3. Mendapatkan FCM Token
    await getToken();

    // 4. Mendengarkan perubahan token
    listenTokenRefresh((newToken) {
      debugPrint('Token terbaru diterima');
    });

    // 5. Pengaturan notifikasi foreground untuk iOS
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 6. FOREGROUND: Aplikasi sedang terbuka
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('[FOREGROUND] Notification received');

        debugPrint(
          'Title: ${message.notification?.title}',
        );

        debugPrint(
          'Body: ${message.notification?.body}',
        );

        debugPrint(
          'Data: ${message.data}',
        );

        // Menampilkan notifikasi lokal ketika aplikasi terbuka
        final title =
            message.notification?.title ?? 'Notifikasi';

        final body =
            message.notification?.body ?? '';

        _localNotifications.show(
          DateTime.now()
              .millisecondsSinceEpoch
              .remainder(100000),
          title,
          body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'kosfinder_channel',
              'KosFinder Notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      },
    );
  }

  // ==========================================
  // PRAKTIK 8: NOTIFICATION PERMISSION
  // ==========================================

  Future<AuthorizationStatus> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission: '
      '${settings.authorizationStatus.name}',
    );

    return settings.authorizationStatus;
  }

  // ==========================================
  // PRAKTIK 9: MENDAPATKAN FCM TOKEN
  // ==========================================

  Future<String?> getToken() async {
    final token = await _messaging.getToken();

    debugPrint('FCM Token: $token');

    return token;
  }

  // Mendengarkan perubahan token
  void listenTokenRefresh(
    void Function(String token) onRefresh,
  ) {
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token diperbarui');

      onRefresh(newToken);
    });
  }
}
