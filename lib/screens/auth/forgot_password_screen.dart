import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_indicator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(_emailController.text.trim());

      if (mounted) { // Pengecekan mounted sebelum menggunakan context
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Instruksi reset password telah dikirim ke email Anda')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) { // Pengecekan mounted sebelum menggunakan context
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal reset password: $e')),
        );
      }
    } finally {
      if (mounted) { // Pengecekan mounted sebelum menggunakan setState
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Lupa Password'),
      body: _isLoading
          ? const LoadingIndicator(message: 'Memproses...')
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Masukkan email Anda untuk menerima instruksi reset password',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email harus diisi';
                        }
                        if (!value.contains('@')) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _resetPassword,
                      child: const Text('RESET PASSWORD'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
