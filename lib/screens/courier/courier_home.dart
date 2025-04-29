import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/order_card.dart';
import '../../providers/order_provider.dart';
import '../../screens/courier/order_pickup.dart';

class CourierHomeScreen extends StatelessWidget {
  const CourierHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders
        .where((order) => order.status == 'processing')
        .toList();
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard Kurir', showBackButton: false),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.directions_bike, size: 40),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesanan Hari Ini',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${orders.length} pesanan',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: orders.isEmpty
                ? const Center(child: Text('Tidak ada pesanan saat ini'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderCard(
                        order: order,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderPickupScreen(
                                order: order,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Buka peta untuk melihat rute
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}
