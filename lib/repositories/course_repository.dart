import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService service;

  CourseRepository(this.service);

  // GET: Mengambil daftar mata kuliah
  Future<List<Course>> getCourses() {
    return service.getCourses();
  }

  // POST: Menambahkan mata kuliah
  Future<Course> createCourse(Course course) {
    return service.createCourse(course);
  }

  // PUT: Memperbarui mata kuliah
  Future<void> updateCourse(int id, Course course) {
    return service.updateCourse(id, course);
  }
}
