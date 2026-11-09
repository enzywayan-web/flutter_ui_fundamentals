
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';
import 'app_keys.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Daftarkan background notification handler
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  // 3. Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://nsnkzcvqikojuccypdke.supabase.co',
    anonKey: 'sb_publishable_jNU1TeG5VLmp1Zw8N2Cuyg_Gsh6GexY',
  );

  // 4. Jalankan aplikasi
  runApp(const KosFinderApp());
}

class KosFinderApp extends StatelessWidget {
  const KosFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosFinder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      home: AuthService.instance.isLoggedIn
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
