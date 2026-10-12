
import 'package:flutter/material.dart';

import 'models/course.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  final Set<String> favorites = <String>{};

  final CourseRepository _repository;

  CourseProvider({CourseRepository? repository})
      : _repository =
            repository ?? CourseRepository(CourseService());

  List<Course> courses = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      courses = await _repository.getCourses();
    } catch (error) {
      errorMessage = error.toString();
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