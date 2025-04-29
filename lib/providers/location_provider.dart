import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  String _currentAddress = 'Mendeteksi lokasi...';

  String get currentAddress => _currentAddress;

  Future<void> getCurrentLocation() async {
    // Simulasi deteksi lokasi
    await Future.delayed(const Duration(seconds: 2));
    _currentAddress = 'Jl. Contoh No. 123, Jakarta';
    notifyListeners();
  }
}