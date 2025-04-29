import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../providers/order_provider.dart';
import '../customer/order_detail_screen.dart';
import '../../widgets/order_card.dart';


class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Riwayat Pesanan'),
      body: orders.isEmpty
          ? const Center(child: Text('Belum ada pesanan'))
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
                        builder: (context) => OrderDetailScreen(order: order),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
