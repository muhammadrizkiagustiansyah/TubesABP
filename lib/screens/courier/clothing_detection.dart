import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../models/order.dart';
import '../../models/clothing_item.dart';

class ClothingDetectionScreen extends StatefulWidget {
  final Order order;

  const ClothingDetectionScreen({super.key, required this.order});

  @override
  State<ClothingDetectionScreen> createState() => _ClothingDetectionScreenState();
}

class _ClothingDetectionScreenState extends State<ClothingDetectionScreen> {
  bool _isDetecting = false;
  List<ClothingItem> _detectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Deteksi Pakaian'),
      body: Column(
        children: [
          Expanded(
            child: _isDetecting
                ? const Center(child: CircularProgressIndicator())
                : _detectedItems.isEmpty
                    ? const Center(child: Text('Belum ada pakaian terdeteksi'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _detectedItems.length,
                        itemBuilder: (context, index) {
                          final item = _detectedItems[index];
                          return ListTile(
                            title: Text(item.name),
                            trailing: Text('${item.quantity}x'),
                          );
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: _startDetection,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Deteksi Pakaian'),
            ),
          ),
          if (_detectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Simpan hasil deteksi
                  Navigator.pop(context);
                },
                child: const Text('SIMPAN HASIL DETEKSI'),
              ),
            ),
        ],
      ),
    );
  }

  void _startDetection() {
    setState(() => _isDetecting = true);
    
    // Simulasi proses deteksi AI
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isDetecting = false;
        _detectedItems = [
          ClothingItem(id: '1', name: 'Kemeja', quantity: 3, price: 10000),
          ClothingItem(id: '2', name: 'Celana Jeans', quantity: 2, price: 15000),
          ClothingItem(id: '3', name: 'Jaket', quantity: 1, price: 20000),
        ];
      });
    });
  }
}