import 'package:flutter/material.dart';

import 'models/course.dart';
import 'services/course_api_service.dart';

const String apiBaseUrl = 'https://course-api-pearl.vercel.app';

final CourseApiService courseApiService = CourseApiService(apiBaseUrl);

class ApiGetDemo extends StatefulWidget {
  const ApiGetDemo({super.key});

  @override
  State<ApiGetDemo> createState() => _ApiGetDemoState();
}

class _ApiGetDemoState extends State<ApiGetDemo> {
  bool isLoading = false;
  List<Course> courses = [];
  String? pesanError;

  Future<void> muatData() async {
    setState(() {
      isLoading = true;
      pesanError = null;
    });

    try {
      final hasil = await courseApiService.getCourses();

      if (!mounted) return;

      setState(() {
        courses = hasil;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
        courses = [];
      });

      debugPrint('Terjadi kesalahan: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Praktikum Tahap 4 - Service Layer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Metode: HTTP GET'),
            const Text('Endpoint: /courses'),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isLoading ? null : muatData,
                icon: const Icon(Icons.cloud_download),
                label: const Text('Ambil Data dari API'),
              ),
            ),
            const SizedBox(height: 12),

            if (isLoading) const Center(child: CircularProgressIndicator()),

            if (pesanError != null)
              Text(
                'Gagal mengambil data: $pesanError',
                style: const TextStyle(color: Colors.red),
              ),

            if (!isLoading && pesanError == null && courses.isNotEmpty)
              Text(
                'Berhasil! Jumlah data: ${courses.length}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

            if (courses.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...courses.map(
                (course) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.menu_book),
                  title: Text('${course.code} - ${course.title}'),
                  subtitle: Text(
                    'Status: ${course.status} | '
                    'Kredit: ${course.credits}',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
