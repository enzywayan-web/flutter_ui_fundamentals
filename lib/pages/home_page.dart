import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart'; // Penting: agar bisa kembali ke halaman login

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KosFinder'),
        actions: [
          // INI DIA TOMBOL LOGOUT (PANAH KELUAR) YANG DIMAKSUD
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout), 
            onPressed: () async {
              await AuthService.instance.logout(); // Menghapus session
              if (!context.mounted) return;
              
              // Kembali ke halaman Login dan hapus semua history
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Login sebagai: ${user?.email ?? 'Tidak diketahui'}'),
      ),
    );
  }
}