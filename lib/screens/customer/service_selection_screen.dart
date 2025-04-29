import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/service.dart';
import '../../models/order.dart';  // Impor model Order
import '../../models/clothing_item.dart'; // Pastikan impor ClothingItem yang dibutuhkan
import '../customer/payment_screen.dart'; // Pastikan path ini benar

class ServiceSelectionScreen extends StatefulWidget {
  final Service selectedService;

  const ServiceSelectionScreen({
    super.key,
    required this.selectedService,
  });

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  String _selectedServiceType = 'regular';
  String _selectedDeliveryOption = 'pickup';
  DateTime? _selectedPickupDate;
  TimeOfDay? _selectedPickupTime;
  final _addressController = TextEditingController();
  final _customerNameController = TextEditingController(); // Nama pelanggan
  final _customerPhoneController = TextEditingController(); // Nomor telepon pelanggan

  // Metode untuk membuat objek Order dan navigasi ke PaymentScreen
  void _navigateToPayment() {
    // Membuat list ClothingItem, sesuaikan sesuai dengan jenis pakaian yang dipilih
    List<ClothingItem> items = [
      ClothingItem(id: 'item1', name: 'Kaos', quantity: 2, price: 50000), // Contoh ClothingItem
    ];

    // Membuat objek Order
    Order order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID unik berdasarkan waktu
      customerName: _customerNameController.text,
      customerPhone: _customerPhoneController.text,
      pickupAddress: _selectedDeliveryOption == 'delivery' ? _addressController.text : '',
      serviceName: widget.selectedService.name,
      status: 'Pending', // Status awal pesanan
      estimatedCompletion: '3 hari', // Estimasi penyelesaian
      totalPrice: widget.selectedService.serviceTypes
          .firstWhere((type) => type.id == _selectedServiceType)
          .price, // Mengambil harga berdasarkan jenis layanan yang dipilih
      paymentMethod: 'QRIS', // Ini bisa diganti sesuai dengan pilihan pembayaran
      pickupDate: _selectedPickupDate != null
          ? '${_selectedPickupDate!.day}/${_selectedPickupDate!.month}/${_selectedPickupDate!.year}'
          : '', // Tanggal penjemputan
      items: items, // Menambahkan items ke pesanan
    );

    // Navigasi ke PaymentScreen dengan objek Order
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(order: order), // Kirim objek Order ke PaymentScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pilih Layanan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.selectedService.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              widget.selectedService.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Nama Pelanggan:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextFormField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Pelanggan',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nomor Telepon:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextFormField(
              controller: _customerPhoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor Telepon',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            Text(
              'Jenis Layanan:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...widget.selectedService.serviceTypes.map((type) {
              return RadioListTile<String>(
                title: Text('${type.name} (${type.duration})'),
                subtitle: Text('Rp ${type.price}'),
                value: type.id,
                groupValue: _selectedServiceType,
                onChanged: (value) {
                  setState(() => _selectedServiceType = value!);
                },
              );
            }),
            const SizedBox(height: 16),
            Text(
              'Opsi Pengantaran:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            RadioListTile<String>(
              title: const Text('Ambil sendiri'),
              value: 'pickup',
              groupValue: _selectedDeliveryOption,
              onChanged: (value) {
                setState(() => _selectedDeliveryOption = value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('Diantar kurir'),
              value: 'delivery',
              groupValue: _selectedDeliveryOption,
              onChanged: (value) {
                setState(() => _selectedDeliveryOption = value!);
              },
            ),
            if (_selectedDeliveryOption == 'delivery') ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Penjemputan',
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 3,
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Tanggal Penjemputan:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              title: Text(
                _selectedPickupDate == null
                    ? 'Pilih Tanggal'
                    : '${_selectedPickupDate!.day}/${_selectedPickupDate!.month}/${_selectedPickupDate!.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) {
                  setState(() => _selectedPickupDate = date);
                }
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Waktu Penjemputan:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              title: Text(
                _selectedPickupTime == null
                    ? 'Pilih Waktu'
                    : _selectedPickupTime!.format(context),
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() => _selectedPickupTime = time);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _navigateToPayment,
              child: const Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }
}
