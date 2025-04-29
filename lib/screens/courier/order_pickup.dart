import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/order.dart';
import '../../screens/courier/clothing_detection.dart';
import '../../screens/courier/navigation_screen.dart';

class OrderPickupScreen extends StatelessWidget {
  final Order order;

  const OrderPickupScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail Pengambilan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Pelanggan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(order.customerName),
              subtitle: Text(order.customerPhone),
            ),
            const SizedBox(height: 16),
            Text(
              'Alamat Pengambilan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Alamat'),
              subtitle: Text(order.pickupAddress),
            ),
            const SizedBox(height: 16),
            Text(
              'Detail Pesanan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.local_laundry_service),
              title: Text(order.serviceName),
              subtitle: Text('Estimasi selesai: ${order.estimatedCompletion}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothingDetectionScreen(order: order),
                  ),
                );
              },
              child: const Text('Deteksi Pakaian'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(order: order),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Mulai Navigasi'),
            ),
          ],
        ),
      ),
    );
  }
}
