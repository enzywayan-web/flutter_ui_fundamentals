import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/course.dart';
import 'services/course_service.dart';

class CourseModelDemo extends StatefulWidget {
  const CourseModelDemo({super.key});

  @override
  State<CourseModelDemo> createState() => _CourseModelDemoState();
}

class _CourseModelDemoState extends State<CourseModelDemo> {
  final CourseService courseService = CourseService();

  late Future<List<Course>> coursesFuture;

  @override
  void initState() {
    super.initState();
    coursesFuture = loadCourses();
  }

  Future<List<Course>> loadCourses() async {
    final response =
        await rootBundle.loadString('assets/data/courses.json');

    final List<dynamic> data = jsonDecode(response) as List<dynamic>;

    return data
        .map(
          (item) => Course.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
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
              'Model Course dari JSON',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Course>>(
              future: coursesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text(
                    'Gagal memuat data: ${snapshot.error}',
                  );
                }

                final courses = snapshot.data ?? [];

                if (courses.isEmpty) {
                  return const Text(
                    'Belum ada data mata kuliah.',
                  );
                }

                return Column(
                  children: courses.map((course) {
                    return ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(course.title),
                      subtitle: Text(
                        'Kode: ${course.code}\n'
                        'SKS: ${course.credits}\n'
                        'Status: ${course.status}',
                      ),
                      isThreeLine: true,
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