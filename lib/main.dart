import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_keys.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nsnkzcvqikojuccypdke.supabase.co', 
    anonKey: 'sb_publishable_jNU1TeG5VLmp1Zw8N2Cuyg_Gsh6GexY',
  );

  runApp(const KosFinderApp());
}

class KosFinderApp extends StatelessWidget {
  const KosFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosFinder',
      debugShowCheckedModeBanner: false, // Menghilangkan pita merah DEBUG
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      home: AuthService.instance.isLoggedIn
          ? const HomePage() // Session Exists -> Home
          : const LoginPage(), // No Session   -> Login
    );
  }
}