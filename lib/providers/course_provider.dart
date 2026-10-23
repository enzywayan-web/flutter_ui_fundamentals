import 'package:flutter/material.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';
import '../services/course_api_service.dart';

class CourseProvider extends ChangeNotifier {
  final Set<String> favorites = <String>{};

  final CourseRepository repository;

  CourseProvider({CourseRepository? repository})
    : repository =
          repository ??
          CourseRepository(
            CourseApiService('https://course-api-pearl.vercel.app'),
          );

  List<Course> courses = [];

  bool isLoading = false;

  String? error;

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    notifyListeners();
  }
}
