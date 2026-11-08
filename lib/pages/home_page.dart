import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../services/kos_service.dart';
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
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  // Fungsi untuk menguji keamanan RLS (Praktik 6)
  void _testSecurity(BuildContext context) async {
    // ID Kos A sudah dimasukkan di sini
    const kosIdA = 'c9d72b10-c67f-4c9f-8880-685f0018c13a'; 

    final kosService = KosService();
    
    // Mencoba mengubah nama kos milik Owner A
    final updateSuccess = await kosService.update(kosIdA, {'name': 'DIHACK OWNER B'});
    
    // Mencoba menghapus kos milik Owner A
    final deleteSuccess = await kosService.delete(kosIdA);

    if (!context.mounted) return;
    
    // Tampilkan hasil di layar (Pop-up)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hasil Uji Keamanan'),
        content: Text(
          'Mencoba mengubah/menghapus data Owner A:\n\n'
          'Update: $updateSuccess\n'
          'Delete: $deleteSuccess',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
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
              if (profile.isAdmin)
                const ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Kelola Data (Admin)'),
                ),
              
              // TOMBOL UJI HACK UNTUK PRAKTIK 6
              const Divider(),
              ListTile(
                leading: const Icon(Icons.security, color: Colors.red),
                title: const Text('UJI HACK (Praktik 6)', style: TextStyle(color: Colors.red)),
                subtitle: const Text('Klik untuk mencoba merusak data Owner A'),
                onTap: () => _testSecurity(context),
              ),
            ],
          );
        },
      ),
    );
  }
}