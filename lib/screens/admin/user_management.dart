import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( // Menggunakan const untuk Scaffold
      appBar: CustomAppBar(title: 'Kelola Pengguna'), // Pastikan CustomAppBar mendukung const
      body: Center(
        child: Text('Daftar pengguna akan ditampilkan di sini'), // Menggunakan const untuk Text
      ),
    );
  }
}
