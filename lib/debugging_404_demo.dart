
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Debugging404Demo extends StatefulWidget {
  const Debugging404Demo({super.key});

  @override
  State<Debugging404Demo> createState() =>
      _Debugging404DemoState();
}

class _Debugging404DemoState extends State<Debugging404Demo> {
  bool isLoading = false;
  String? errorMessage;
  int? statusCode;

  Future<void> test404() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      statusCode = null;
    });

    try {
      final response = await http
          .get(
            Uri.parse(
              'https://jsonplaceholder.typicode.com/invalid-endpoint-404',
            ),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 404) {
        setState(() {
          statusCode = response.statusCode;
          errorMessage =
              'HTTP 404: Endpoint tidak ditemukan. '
              'Periksa kembali alamat endpoint.';
        });
      } else {
        setState(() {
          statusCode = response.statusCode;
          errorMessage =
              'Server merespons dengan status '
              '${response.statusCode}.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage =
            'Permintaan gagal. Periksa koneksi internet '
            'dan coba lagi.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debugging HTTP 404'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Pengujian Endpoint Salah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              if (statusCode != null)
                Text('Status HTTP: $statusCode'),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: isLoading ? null : test404,
                icon: const Icon(Icons.refresh),
                label: Text(
                  isLoading ? 'Memeriksa...' : 'Uji Lagi',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
