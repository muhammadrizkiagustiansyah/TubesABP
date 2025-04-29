import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isAuthenticated = false;
  String _userRole = 'customer';

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  String get userRole => _userRole;

  Future<void> login(String email, String password) async {
    // Simulasi login
    await Future.delayed(const Duration(seconds: 1));
    
    _user = User(
      id: '1',
      name: 'John Doe',
      email: email,
      phone: '08123456789',
      role: _userRole,
      address: 'Jl. Contoh No. 123, Jakarta',
    );
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
    String role,
  ) async {
    // Simulasi registrasi
    await Future.delayed(const Duration(seconds: 1));
    
    _userRole = role;
    _user = User(
      id: '1',
      name: name,
      email: email,
      phone: phone,
      role: role,
    );
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    // Simulasi reset password
    await Future.delayed(const Duration(seconds: 1));
  }

  void logout() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
