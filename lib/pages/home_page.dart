import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../services/kos_service.dart';
import '../services/notification_service.dart'; // Tambahan
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService().getMyProfile();
    
    // Memanggil inisialisasi notifikasi saat Home terbuka
    NotificationService.instance.init();
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void _testSecurity(BuildContext context) async {
    const kosId = 'MASUKKAN_ID_KOS_DISINI'; 

    try {
      final kosService = KosService();
      final updateSuccess = await kosService.update(kosId, {'name': 'Kos Berhasil Diedit'});
      final deleteSuccess = await kosService.delete(kosId);

      if (!context.mounted) return;
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hasil Uji Keamanan'),
          content: Text('Update: $updateSuccess\nDelete: $deleteSuccess'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Pesan: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KosFinder'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<UserProfile?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Gagal memuat profil'));
          }

          final profile = snapshot.data!;

          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(profile.name.isEmpty ? profile.email : profile.name),
                subtitle: Text('${profile.email} • ${profile.role}'),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.list),
                title: Text('Daftar Kos'),
              ),
              if (profile.isOwner || profile.isAdmin)
                const ListTile(
                  leading: Icon(Icons.home_work),
                  title: Text('My Kos'),
                ),
              
              // TOMBOL UJI HACK (Untuk Praktik 6)
              const Divider(),
              ListTile(
                leading: const Icon(Icons.security, color: Colors.red),
                title: const Text('UJI HACK (Praktik 6)', style: TextStyle(color: Colors.red)),
                onTap: () => _testSecurity(context),
              ),
            ],
          );
        },
      ),
    );
  }
}