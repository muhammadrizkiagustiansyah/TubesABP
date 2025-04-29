import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../providers/order_provider.dart';
import 'service_detail_screen.dart';


class ServiceManagementScreen extends StatelessWidget {
  const ServiceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<OrderProvider>(context).services;
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kelola Layanan'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Tambah layanan baru
              },
              child: const Text('TAMBAH LAYANAN BARU'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Card(
                  child: ListTile(
                    title: Text(service.name),
                    subtitle: Text(service.description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(
                            service: service,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}