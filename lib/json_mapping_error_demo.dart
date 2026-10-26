
import 'package:flutter/material.dart';
import 'models/course.dart';

class JsonMappingErrorDemo extends StatefulWidget {
  const JsonMappingErrorDemo({super.key});

  @override
  State<JsonMappingErrorDemo> createState() =>
      _JsonMappingErrorDemoState();
}

class _JsonMappingErrorDemoState
    extends State<JsonMappingErrorDemo> {
  String result = 'Tekan tombol untuk menguji JSON mapping error.';

  void testJsonMapping() {
    final invalidJson = <String, dynamic>{
      'id': 1,
      'code': 'TIK19505',
      'name': 'Pemrograman Mobile',
      // Sengaja memakai "name", bukan "title".
      'credits': 3,
      'status': 'planned',
    };

    try {
      final course = Course.fromJson(invalidJson);

      setState(() {
        result = 'Data berhasil dipetakan: ${course.title}';
      });
    } catch (e) {
      setState(() {
        result =
            'JSON Mapping Error berhasil ditangkap.\n\n'
            'Jenis error: ${e.runtimeType}\n'
            'Detail: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengujian JSON Mapping'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.data_object,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Kasus C: JSON Mapping Error',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SelectableText(
                result,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: testJsonMapping,
                icon: const Icon(Icons.bug_report),
                label: const Text('Uji JSON Salah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
