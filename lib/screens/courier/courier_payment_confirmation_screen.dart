import 'package:flutter/material.dart';

class CourierPaymentConfirmationScreen extends StatelessWidget {
  final String orderId;

  const CourierPaymentConfirmationScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pembayaran Tunai')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Konfirmasi Pembayaran Tunai untuk Order ID: $orderId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Kode untuk mengonfirmasi pembayaran tunai, kirim API untuk update status pembayaran
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pembayaran Tunai Dikonfirmasi")),
                );
                Navigator.pop(context);  // Navigasi kembali ke halaman sebelumnya setelah konfirmasi
              },
              child: const Text('Konfirmasi Pembayaran Tunai'),
            ),
          ],
        ),
      ),
    );
  }
}
