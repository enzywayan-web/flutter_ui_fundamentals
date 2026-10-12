
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';

class CourseProviderDemo extends StatelessWidget {
  const CourseProviderDemo({super.key});

  static const List<String> courses = [
    'Flutter',
    'Dart',
    'UI Design',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Eksperimen watch, read, dan Consumer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // watch digunakan untuk mendengarkan jumlah favorit.
            const FavoriteCount(),

            const Divider(),

            ...courses.map((course) {
              return ListTile(
                title: Text(course),

                // Consumer membatasi pembaruan pada ikon favorit.
                trailing: Consumer<CourseProvider>(
                  builder: (context, provider, child) {
                    final isFavorite =
                        provider.favorites.contains(course);

                    return Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    );
                  },
                ),

                // read digunakan untuk menjalankan aksi.
                onTap: () {
                  context
                      .read<CourseProvider>()
                      .toggleFavorite(course);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class FavoriteCount extends StatelessWidget {
  const FavoriteCount({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Text(
      'Jumlah favorit: ${provider.favorites.length}',
    );
  }
}