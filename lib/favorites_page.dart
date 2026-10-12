
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Satu state favorites dimiliki oleh parent.
  Set<String> favorites = {'Flutter'};

  void toggleFavorite(String course) {
    setState(() {
      if (favorites.contains(course)) {
        favorites.remove(course);
      } else {
        favorites.add(course);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eksperimen Prop Drilling'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Tahap 2: Masalah setState()',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'State favorites disimpan pada parent, '
              'kemudian diteruskan ke dua child melalui constructor.',
            ),
            const SizedBox(height: 20),

            // Child pertama menerima favorites dan callback.
            FavoriteSummary(
              favorites: favorites,
              onToggleFavorite: toggleFavorite,
            ),

            const SizedBox(height: 16),

            // Child kedua menerima favorites dan callback yang sama.
            FavoriteControls(
              favorites: favorites,
              onToggleFavorite: toggleFavorite,
            ),

            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Catatan: kedua child menerima data dari parent. '
              'Jika struktur widget semakin dalam, data dan callback '
              'harus diteruskan melalui widget perantara.',
            ),
          ],
        ),
      ),
    );
  }
}

// CHILD A: menampilkan ringkasan favorites.
class FavoriteSummary extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onToggleFavorite;

  const FavoriteSummary({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child A: Favorite Summary',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Jumlah favorit: ${favorites.length}'),
            Text(
              'Daftar favorit: '
              '${favorites.isEmpty ? "Belum ada" : favorites.join(", ")}',
            ),
          ],
        ),
      ),
    );
  }
}

// CHILD B: menampilkan tombol untuk mengubah favorites.
class FavoriteControls extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onToggleFavorite;

  const FavoriteControls({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    const courses = ['Flutter', 'Dart', 'UI Design'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child B: Favorite Controls',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Tekan tombol untuk mengubah daftar favorit.'),
            const SizedBox(height: 8),
            ...courses.map((course) {
              final isFavorite = favorites.contains(course);

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(course),
                trailing: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onTap: () => onToggleFavorite(course),
              );
            }),
          ],
        ),
      ),
    );
  }
}