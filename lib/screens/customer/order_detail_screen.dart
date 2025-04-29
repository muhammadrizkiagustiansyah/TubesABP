import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/order.dart';
import '../customer/payment_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail Pesanan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${order.id}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Chip(
                          label: Text(
                            order.status.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: _getStatusColor(order.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      context,
                      Icons.local_laundry_service,
                      'Layanan',
                      order.serviceName,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.timer,
                      'Estimasi Selesai',
                      order.estimatedCompletion,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.calendar_today,
                      'Tanggal Jemput',
                      order.pickupDate,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.payment,
                      'Total Pembayaran',
                      'Rp ${order.totalPrice}',
                    ),
                    _buildDetailRow(
                      context,
                      Icons.credit_card,
                      'Metode Pembayaran',
                      order.paymentMethod,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Detail Pakaian:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Menghilangkan penggunaan toList()
            ...order.items.map((item) {
              return ListTile(
                title: Text('${item.quantity}x ${item.name}'),
                trailing: Text('Rp ${item.price}'),
              );
            }),
            const SizedBox(height: 16),
            if (order.status == 'pending')
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(order: order),
                    ),
                  );
                },
                child: const Text('Bayar Sekarang'),
              ),
            if (order.status == 'processing')
              const Text(
                'Pesanan Anda sedang diproses',
                style: TextStyle(color: Colors.blue),
              ),
            if (order.status == 'completed')
              const Text(
                'Pesanan telah selesai',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 16),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
