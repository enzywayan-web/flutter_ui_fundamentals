import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';
import 'models/course.dart';

class CourseProviderDemo extends StatelessWidget {
  const CourseProviderDemo({super.key});

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

            // Memuat dan menampilkan data course dari repository melalui provider
            ElevatedButton(
              onPressed: () {
                context.read<CourseProvider>().loadCourses();
              },
              child: const Text('Muat Course dari Repository'),
            ),
            const SizedBox(height: 8),

            Consumer<CourseProvider>(
              builder: (context, provider, child) {
                final courses = provider.courses;

                if (courses.isEmpty) {
                  return const Text('Belum ada course yang dimuat.');
                }

                return Column(
                  children: courses.map((course) {
                    final String courseName = course.title;
                    final isFavorite =
                        provider.favorites.contains(courseName);

                    return ListTile(
                      title: Text(courseName),
                      subtitle: Text(
                        'Kode: ${course.code} | SKS: ${course.credits}',
                      ),
                      // Consumer membatasi pembaruan pada ikon favorit.
                      trailing: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      // read digunakan untuk menjalankan aksi.
                      onTap: () {
                        context
                            .read<CourseProvider>()
                            .toggleFavorite(courseName);
                      },
                    );
                  }).toList(),
                );
              },
            ),
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