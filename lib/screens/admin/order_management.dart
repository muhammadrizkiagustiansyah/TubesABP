import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/order.dart';

class OrderManagementScreen extends StatefulWidget {
  final Order order;

  const OrderManagementScreen({super.key, required this.order});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  late String _selectedStatus;
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.order.status;
    _priceController.text = widget.order.totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kelola Pesanan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pesanan #${widget.order.id}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Nama Pelanggan', widget.order.customerName),
            _buildDetailRow('Nomor HP', widget.order.customerPhone),
            _buildDetailRow('Alamat', widget.order.pickupAddress),
            _buildDetailRow('Layanan', widget.order.serviceName),
            _buildDetailRow('Estimasi Selesai', widget.order.estimatedCompletion),
            const SizedBox(height: 16),
            Text(
              'Detail Pakaian:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // Menghilangkan penggunaan toList()
            ...widget.order.items.map((item) {
              return ListTile(
                title: Text('${item.quantity}x ${item.name}'),
                trailing: Text('Rp ${item.price}'),
              );
            }),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Total Harga',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status Pesanan',
                prefixIcon: Icon(Icons.list), // Ganti dengan ikon yang valid
              ),
              items: const [
                DropdownMenuItem(
                  value: 'pending',
                  child: Text('Pending'),
                ),
                DropdownMenuItem(
                  value: 'processing',
                  child: Text('Diproses'),
                ),
                DropdownMenuItem(
                  value: 'completed',
                  child: Text('Selesai'),
                ),
                DropdownMenuItem(
                  value: 'cancelled',
                  child: Text('Dibatalkan'),
                ),
              ],
              onChanged: (value) {
                setState(() => _selectedStatus = value!);
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Simpan perubahan
                      Navigator.pop(context);
                    },
                    child: const Text('SIMPAN PERUBAHAN'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Hapus pesanan
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('HAPUS PESANAN'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
