import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/order.dart';

class NavigationScreen extends StatelessWidget {
  final Order order;

  const NavigationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Navigasi'),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text('PETA OSM AKAN DITAMPILKAN DI SINI'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.location_on, color: Colors.red),
                  title: Text('Lokasi Anda'),
                  subtitle: Text('Sedang dalam perjalanan...'),
                ),
                ListTile(
                  leading: const Icon(Icons.flag, color: Colors.green),
                  title: const Text('Tujuan'),
                  subtitle: Text(order.pickupAddress),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Tandai sudah sampai
                    Navigator.pop(context);
                  },
                  child: const Text('SUDAH SAMPAI'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
