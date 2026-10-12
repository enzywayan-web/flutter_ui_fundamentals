
import 'package:flutter/material.dart';
import 'course_state.dart';

class CourseStateDemo extends StatefulWidget {
  const CourseStateDemo({super.key});

  @override
  State<CourseStateDemo> createState() => _CourseStateDemoState();
}

class _CourseStateDemoState extends State<CourseStateDemo> {
  late final CourseState courseState;

  @override
  void initState() {
    super.initState();
    courseState = CourseState();
  }

  @override
  void dispose() {
    courseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const courseNames = [
      'Flutter',
      'Dart',
      'UI Design',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eksperimen ChangeNotifier',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih course untuk menambah atau menghapus favorit.',
            ),
            const SizedBox(height: 12),

            AnimatedBuilder(
              animation: courseState,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah favorit: ${courseState.favorites.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    for (final course in courseNames)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(course),
                        trailing: Icon(
                          courseState.favorites.contains(course)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: courseState.favorites.contains(course)
                              ? Colors.red
                              : null,
                        ),
                        onTap: () {
                          courseState.toggleFavorite(course);
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}