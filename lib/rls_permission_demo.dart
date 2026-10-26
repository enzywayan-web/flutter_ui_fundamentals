
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RlsPermissionDemo extends StatefulWidget {
  const RlsPermissionDemo({super.key});

  @override
  State<RlsPermissionDemo> createState() => _RlsPermissionDemoState();
}

class _RlsPermissionDemoState extends State<RlsPermissionDemo> {
  bool isTesting = false;
  String result = 'Tekan tombol untuk memulai pengujian.';
  String? errorType;

  Future<void> testPermission() async {
    setState(() {
      isTesting = true;
      result = 'Sedang menguji akses Supabase...';
      errorType = null;
    });

    try {
      // SELECT saja: tidak menambah, mengubah, atau menghapus data.
      await Supabase.instance.client
          .from('courses')
          .select('id')
          .limit(1);

      if (!mounted) return;

      setState(() {
        result =
            'Request SELECT berhasil. Policy saat ini mengizinkan '
            'request ini atau tidak memblokirnya.';
      });
    } on PostgrestException catch (e) {
      if (!mounted) return;

      setState(() {
        errorType = 'PostgrestException';
        result = 'Request database ditolak atau gagal.\n'
            'Kode: ${e.code ?? "-"}\n'
            'Pesan: ${e.message}';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorType = e.runtimeType.toString();
        result = 'Request gagal.\n$e';
      });
    } finally {
      if (mounted) {
        setState(() => isTesting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.security, size: 52),
              const SizedBox(height: 12),
              const Text(
                'Kasus D — RLS / Permission',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Pengujian SELECT pada tabel courses. '
                'Pengujian ini tidak mengubah data.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isTesting ? null : testPermission,
                icon: const Icon(Icons.play_arrow),
                label: Text(
                  isTesting ? 'Menguji...' : 'Uji Permission',
                ),
              ),
              const SizedBox(height: 20),
              SelectableText(
                result,
                textAlign: TextAlign.center,
              ),
              if (errorType != null) ...[
                const SizedBox(height: 8),
                Text('Jenis error: $errorType'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
