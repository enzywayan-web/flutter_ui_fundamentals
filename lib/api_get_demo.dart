
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Endpoint REST API dari dosen.
const String apiUrl =
    'https://course-api-pearl.vercel.app/courses';

// Fungsi asynchronous untuk mengambil data course.
Future<List<dynamic>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));

  debugPrint('HTTP Status Code: ${response.statusCode}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;

    debugPrint('Jumlah data course: ${data.length}');

    return data;
  }

  throw Exception('HTTP ${response.statusCode}');
}

// Widget untuk menguji HTTP GET pada aplikasi.
class ApiGetDemo extends StatefulWidget {
  const ApiGetDemo({super.key});

  @override
  State<ApiGetDemo> createState() => _ApiGetDemoState();
}

class _ApiGetDemoState extends State<ApiGetDemo> {
  bool isLoading = false;
  int? jumlahData;
  String? pesanError;

  Future<void> muatData() async {
    setState(() {
      isLoading = true;
      pesanError = null;
      jumlahData = null;
    });

    try {
      final data = await fetchCourses();

      if (!mounted) return;

      setState(() {
        jumlahData = data.length;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
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
              'Praktikum Tahap 2 - HTTP GET',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Endpoint: /courses'),
            const Text('Metode: GET'),
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
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (jumlahData != null)
              Text(
                'Berhasil! Jumlah data: $jumlahData',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (pesanError != null)
              Text(
                'Gagal mengambil data: $pesanError',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
