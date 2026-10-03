import 'package:flutter/material.dart';

const String studentName = 'Ni Wayan Enzy Ariantini';
const String studentId = '2415051070';

void main() {
  runApp(const DebuggingApp());
}

class DebuggingApp extends StatelessWidget {
  const DebuggingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 16 - Debugging',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const DebuggingPage(),
    );
  }
}

class DebuggingPage extends StatefulWidget {
  const DebuggingPage({super.key});

  @override
  State<DebuggingPage> createState() => _DebuggingPageState();
}

class _DebuggingPageState extends State<DebuggingPage> {
  bool isLoading = false;
  bool isNavigating = false;

  // =========================
  // KASUS D - MENCEGAH NAVIGASI GANDA
  // =========================
  Future<void> openDetail() async {
    if (isNavigating) return;

    setState(() {
      isNavigating = true;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailPage(),
      ),
    );

    if (!mounted) return;

    setState(() {
      isNavigating = false;
    });
  }

  // =========================
  // KASUS C - SIMULASI LOADING
  // =========================
  Future<void> simulateLoading() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proses selesai'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 16 - Debugging'),
      ),

      // SingleChildScrollView membantu kasus keyboard
      // agar halaman dapat digeser saat keyboard muncul.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // IDENTITAS
            // =========================
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Identitas Mahasiswa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Nama: $studentName'),
                    Text('NIM: $studentId'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // KASUS A
            // =========================
            const Text(
              'Kasus A - Row Overflow',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info),
                  const SizedBox(width: 8),

                  // Expanded membuat Text menggunakan
                  // ruang yang tersedia dan dapat membungkus.
                  Expanded(
                    child: Text(
                      '$studentId - $studentName - '
                      'Teks yang cukup panjang untuk '
                      'menguji responsive layout.',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // KASUS B
            // =========================
            const Text(
              'Kasus B - ListView dalam Column',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Expanded memberikan batas tinggi kepada ListView.
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(
                        'Course ${index + 1}',
                      ),
                      subtitle: const Text(
                        'ListView memiliki tinggi yang jelas.',
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // KASUS C
            // =========================
            const Text(
              'Kasus C - Keyboard Overflow',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Masukkan komentar',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 10),

            const Text(
              'Halaman menggunakan SingleChildScrollView '
              'agar konten tetap dapat diakses ketika keyboard muncul.',
            ),

            const SizedBox(height: 20),

            // =========================
            // KASUS D
            // =========================
            const Text(
              'Kasus D - Navigasi Ganda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    isNavigating ? null : openDetail,
                child: Text(
                  isNavigating
                      ? 'Membuka halaman...'
                      : 'Buka Detail',
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // LOADING
            // =========================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    isLoading ? null : simulateLoading,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        'Simulasi Loading',
                      ),
              ),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                'Debugging selesai',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// DETAIL PAGE
// =========================

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 70,
            ),
            const SizedBox(height: 15),
            const Text(
              'Halaman Detail',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Nama: $studentName'),
            Text('NIM: $studentId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}