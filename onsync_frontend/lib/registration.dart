import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F54), // Dark blue background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Registration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign up to create your account',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField('Enter your email'),
              const SizedBox(height: 16),
              _buildTextField('Enter new username'),
              const SizedBox(height: 16),
              _buildTextField('Enter new password'),
              const SizedBox(height: 16),
              _buildTextField('Re-enter new password'),
              const SizedBox(height: 24),
              _buildButton('Create Account', Colors.brown[300]!),
              const SizedBox(height: 16),
              const Text(
                'Already have an account?',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              _buildButton('Login', Colors.brown[300]!),
            ],
          ),
        ),
      ),
    );
  }