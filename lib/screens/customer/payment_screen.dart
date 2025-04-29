import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/order.dart';

class PaymentScreen extends StatefulWidget {
  final Order order;

  const PaymentScreen({super.key, required this.order});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'qris';
  bool _isLoading = false;

  Future<void> _processPayment() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pembayaran berhasil diproses'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pembayaran'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pembayaran:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Rp ${widget.order.totalPrice}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Pilih Metode Pembayaran:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  PaymentMethodCard(
                    icon: Icons.qr_code,
                    title: 'QRIS',
                    isSelected: _selectedPaymentMethod == 'qris',
                    onTap: () {
                      setState(() => _selectedPaymentMethod = 'qris');
                    },
                  ),
                  PaymentMethodCard(
                    icon: Icons.account_balance,
                    title: 'Transfer Bank',
                    isSelected: _selectedPaymentMethod == 'transfer',
                    onTap: () {
                      setState(() => _selectedPaymentMethod = 'transfer');
                    },
                  ),
                  PaymentMethodCard(
                    icon: Icons.money,
                    title: 'Tunai',
                    isSelected: _selectedPaymentMethod == 'cash',
                    onTap: () {
                      setState(() => _selectedPaymentMethod = 'cash');
                    },
                  ),
                  const SizedBox(height: 32),
                  if (_selectedPaymentMethod == 'qris') ...[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code, size: 100),
                            Text('Scan QR Code untuk pembayaran'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Instruksi: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '1. Buka aplikasi mobile banking atau e-wallet Anda\n'
                      '2. Pilih pembayaran QRIS\n'
                      '3. Scan QR code di atas\n'
                      '4. Konfirmasi pembayaran',
                    ),
                  ],
                  if (_selectedPaymentMethod == 'transfer') ...[
                    const Text(
                      'Transfer ke rekening berikut: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('Bank: BCA'),
                    const Text('Nomor Rekening: 1234567890'),
                    const Text('Atas Nama: Laundry Online'),
                    const SizedBox(height: 8),
                    const Text(
                      'Pastikan nominal transfer sesuai dengan total pembayaran',
                    ),
                  ],
                  if (_selectedPaymentMethod == 'cash') ...[
                    const Text(
                      'Pembayaran tunai akan dikonfirmasi oleh kurir saat pengambilan.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                  const SizedBox(height: 32),
                  if (_selectedPaymentMethod != 'cash')
                    ElevatedButton(
                      onPressed: _processPayment,
                      child: const Text('KONFIRMASI PEMBAYARAN'),
                    ),
                ],
              ),
            ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: isSelected ? Colors.blueAccent : Colors.white,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: isSelected
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.radio_button_unchecked),
        ),
      ),
    );
  }
}
