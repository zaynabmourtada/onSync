import 'package:flutter/material.dart';
import 'api_service.dart';

class LoginScreen extends StatelessWidget {
  final ApiService apiService;

  const LoginScreen({Key? key, required this.apiService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Text('Login Screen'),
      ),
    );
  }
}
