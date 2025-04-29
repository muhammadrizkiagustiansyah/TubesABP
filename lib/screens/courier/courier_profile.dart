import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourierProfileScreen extends StatefulWidget {
  const CourierProfileScreen({super.key});

  @override
  _CourierProfileScreenState createState() => _CourierProfileScreenState();
}

class _CourierProfileScreenState extends State<CourierProfileScreen> {
  String _name = "";
  String _phone = "";

  // Fungsi untuk mengambil data dari SharedPreferences
  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'Name not set';
      _phone = prefs.getString('phone') ?? 'Phone not set';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Kurir'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Fungsi logout bisa dibentuk di sini
              _logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $_name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Telepon: $_phone', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  // Fungsi logout
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data yang tersimpan
    Navigator.pushReplacementNamed(context, '/login'); // Navigasi ke layar login
  }
}
