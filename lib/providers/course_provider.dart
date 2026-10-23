import 'package:flutter/material.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.repository);

  final CourseRepository repository;

  final Set<String> favorites = <String>{};

  List<Course> courses = [];
  bool isLoading = false;
  bool isSaving = false;
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

  Future<Course> createCourse(Course course) async {
    if (isSaving) {
      throw Exception('Penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    notifyListeners();

    try {
      final createdCourse = await repository.createCourse(course);
      await loadCourses();
      return createdCourse;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateCourse(int id, Course course) async {
    if (isSaving) {
      throw Exception('Penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);
      await loadCourses();
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> deleteCourse(Course course) async {
    final id = course.id;

    if (id == null || isSaving) return;

    isSaving = true;
    notifyListeners();

    try {
      await repository.deleteCourse(id);

      // Hapus juga dari favorites berdasarkan code.
      favorites.remove(course.code);

      // Muat ulang data dari API.
      await loadCourses();
    } finally {
      isSaving = false;
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