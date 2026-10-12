
import 'package:flutter/material.dart';

class CourseState extends ChangeNotifier {
  // Satu sumber data untuk daftar favorit.
  final Set<String> favorites = <String>{};

  // Menambah atau menghapus favorit.
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    // Memberi tahu listener bahwa state berubah.
    notifyListeners();
  }
}