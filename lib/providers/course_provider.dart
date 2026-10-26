
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

  // Tahap 13: INSERT data mata kuliah
  Future<Course> createCourse(Course course) async {
    if (isSaving) {
      throw Exception('Penyimpanan sedang berlangsung.');
    }

    // Periksa kode duplikat pada data yang sudah dimuat.
    final normalizedCode = course.code.trim().toLowerCase();

    final isDuplicate = courses.any(
      (existingCourse) =>
          existingCourse.code.trim().toLowerCase() ==
          normalizedCode,
    );

    if (isDuplicate) {
      throw Exception(
        'Kode mata kuliah ${course.code.trim()} sudah digunakan.',
      );
    }

    isSaving = true;
    notifyListeners();

    try {
      final createdCourse =
          await repository.createCourse(course);

      await loadCourses();

      return createdCourse;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Tahap 14: UPDATE data mata kuliah
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

  // DELETE data mata kuliah
  Future<void> deleteCourse(Course course) async {
    final id = course.id;

    if (id == null || isSaving) return;

    isSaving = true;
    notifyListeners();

    try {
      await repository.deleteCourse(id);
      favorites.remove(course.code);
      await loadCourses();
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Mengatur mata kuliah favorit
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    notifyListeners();
  }
}
