import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

// Model untuk Payment (dapat diletakkan di file terpisah)
class Payment {
  final String id;
  final String orderId;
  final double amount;
  final String method;
  final String status;
  final DateTime paymentDate;

  Payment({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.method,
    required this.status,
    required this.paymentDate,
  });
}

// Model Service dan ServiceType
class Service {
  final String id;
  final String name;
  final String description;
  final List<ServiceType> serviceTypes;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.serviceTypes,
  });
}

class ServiceType {
  final String id;
  final String name;
  final String duration;
  final double price;

  ServiceType({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
  });
}

class PaymentScreen extends StatelessWidget {
  final Service selectedService;
  final String selectedServiceType;
  final String selectedDeliveryOption;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;
  final String address;

  const PaymentScreen({
    super.key,
    required this.selectedService,
    required this.selectedServiceType,
    required this.selectedDeliveryOption,
    required this.pickupDate,
    required this.pickupTime,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    // Mencari ServiceType yang dipilih berdasarkan nama
    final selectedType = selectedService.serviceTypes
        .firstWhere((type) => type.name == selectedServiceType);

    // Contoh membuat pembayaran menggunakan model Payment
    final payment = Payment(
      id: '123456',
      orderId: 'order_001',
      amount: selectedType.price, // Menggunakan harga dari selectedServiceType
      method: 'Transfer', // Metode pembayaran
      status: 'Pending', // Status pembayaran
      paymentDate: DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Layanan:'),
            Text('Layanan: ${selectedService.name}'),
            Text('Jenis Layanan: $selectedServiceType'),
            Text('Deskripsi Layanan: ${selectedService.description}'),
            Text('Opsi Pengantaran: $selectedDeliveryOption'),
            Text('Tanggal Penjemputan: ${pickupDate != null ? DateFormat('dd/MM/yyyy').format(pickupDate!) : 'Belum dipilih'}'),
            Text('Waktu Penjemputan: ${pickupTime != null ? pickupTime!.format(context) : 'Belum dipilih'}'),
            if (selectedDeliveryOption == 'delivery') Text('Alamat: $address'),
            const SizedBox(height: 24),
            Text('Metode Pembayaran: ${payment.method}'),
            Text('Jumlah: Rp ${payment.amount}'),
            Text('Status: ${payment.status}'),
            Text('Tanggal Pembayaran: ${DateFormat('dd/MM/yyyy HH:mm').format(payment.paymentDate)}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Proses pembayaran (misalnya: mengonfirmasi pembayaran)
                // Navigasi atau aksi sesuai kebutuhan
              },
              child: const Text('Konfirmasi Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
