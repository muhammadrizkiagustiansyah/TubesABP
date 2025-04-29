import 'package:flutter/material.dart';
import '../../models/service.dart'; // Mengimpor model Service

class ServiceDetailScreen extends StatelessWidget {
  final Service service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.name, 
              style: Theme.of(context).textTheme.titleLarge, // Menggunakan titleLarge
            ),
            const SizedBox(height: 8),
            Text(service.description),
            const SizedBox(height: 16),
            Text(
              'Tipe Layanan:',
              style: Theme.of(context).textTheme.titleLarge, // Menggunakan titleLarge
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: service.serviceTypes.length,
                itemBuilder: (context, index) {
                  final serviceType = service.serviceTypes[index];
                  return Card(
                    child: ListTile(
                      title: Text(serviceType.name),
                      subtitle: Text('Durasi: ${serviceType.duration}'),
                      trailing: Text('Rp${serviceType.price.toStringAsFixed(2)}'),
                      onTap: () {
                        // Menambahkan logika jika ingin mengedit atau melakukan aksi lain
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Fungsi untuk mengedit layanan atau melakukan aksi lain
              },
              child: const Text('Edit Layanan'),
            ),
          ],
        ),
      ),
    );
  }
}
