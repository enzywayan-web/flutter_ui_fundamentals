
import 'package:flutter/material.dart';

class ValueNotifierDemoCard extends StatefulWidget {
  const ValueNotifierDemoCard({super.key});

  @override
  State<ValueNotifierDemoCard> createState() =>
      _ValueNotifierDemoCardState();
}

class _ValueNotifierDemoCardState
    extends State<ValueNotifierDemoCard> {
  // ValueNotifier menyimpan nilai counter.
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eksperimen ValueNotifier',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ubah nilai counter tanpa memanggil setState() '
              'untuk memperbarui angka.',
            ),
            const SizedBox(height: 16),

            // Tampilan mendengarkan perubahan counter.
            Center(
              child: ValueListenableBuilder<int>(
                valueListenable: counter,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      const Text('Jumlah Favorit'),
                      const SizedBox(height: 8),
                      Text(
                        '$value',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: () {
                    if (counter.value > 0) {
                      counter.value--;
                    }
                  },
                  icon: const Icon(Icons.remove),
                  tooltip: 'Kurangi nilai',
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () {
                    counter.value++;
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('+1'),
                ),
              ],
            ),
            const Divider(height: 24),
            const Text(
              'Nilai berubah melalui ValueNotifier. '
              'ValueListenableBuilder memperbarui angka '
              'ketika nilai counter berubah.',
            ),
          ],
        ),
      ),
    );
  }
}