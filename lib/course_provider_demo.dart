
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/course_provider.dart';

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
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<CourseProvider>().loadCourses();
              },
              child: const Text('Muat Data Mata Kuliah'),
            ),
            const SizedBox(height: 12),
            Consumer<CourseProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const CircularProgressIndicator();
                }

                if (provider.error != null) {
                  return Text(
                    'Terjadi kesalahan: ${provider.error}',
                  );
                }

                if (provider.courses.isEmpty) {
                  return const Text(
                    'Tekan tombol untuk memuat data mata kuliah.',
                  );
                }

                return Column(
                  children: provider.courses.map((course) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(course.title),
                      subtitle: Text(
                        '${course.code} • ${course.credits} SKS',
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const Divider(),
            const FavoriteCount(),
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
    final count = context.watch<CourseProvider>().favorites.length;

    return Text('Jumlah mata kuliah favorit: $count');
  }
}