import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class EditCourseScreen extends StatefulWidget {
  final Course course;

  const EditCourseScreen({super.key, required this.course});

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _codeController;
  late final TextEditingController _titleController;
  late final TextEditingController _creditsController;

  late String _status;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    // Mengisi form menggunakan data mata kuliah lama.
    _codeController = TextEditingController(text: widget.course.code);
    _titleController = TextEditingController(text: widget.course.title);
    _creditsController = TextEditingController(
      text: widget.course.credits.toString(),
    );

    _status = widget.course.status;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    final id = widget.course.id;

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID mata kuliah tidak ditemukan.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final updatedCourse = Course(
        id: id,
        code: widget.course.code,
        title: _titleController.text.trim(),
        credits: int.parse(_creditsController.text.trim()),
        status: _status,
      );

      await context.read<CourseProvider>().updateCourse(id, updatedCourse);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mata kuliah berhasil diperbarui.')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui mata kuliah: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Mata Kuliah')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ni Wayan Enzy Ariantini',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('NIM: 2415051070'),
              const SizedBox(height: 20),

              TextFormField(
                controller: _codeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Kode Mata Kuliah',
                  border: OutlineInputBorder(),
                  helperText: 'Kode mata kuliah tidak dapat diubah.',
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama mata kuliah wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _creditsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah SKS',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final credits = int.tryParse(value ?? '');

                  if (credits == null || credits < 1 || credits > 6) {
                    return 'Masukkan jumlah SKS antara 1–6.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'planned',
                    child: Text('Belum Dimulai'),
                  ),
                  DropdownMenuItem(
                    value: 'active',
                    child: Text('Sedang Dipelajari'),
                  ),
                  DropdownMenuItem(value: 'done', child: Text('Selesai')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _isSubmitting ? null : _saveChanges,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
