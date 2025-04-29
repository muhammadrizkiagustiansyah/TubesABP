import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class PricingManagementScreen extends StatelessWidget {
  const PricingManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( // Menggunakan const untuk Scaffold
      appBar: CustomAppBar(title: 'Kelola Harga'), // Pastikan CustomAppBar mendukung const
      body: Center(
        child: Text('Daftar harga akan ditampilkan di sini'), // Menggunakan const untuk Text
      ),
    );
  }
}
