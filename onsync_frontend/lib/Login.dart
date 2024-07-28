import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01204E),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 430,
            height: 932,
            decoration: const BoxDecoration(
              color: Color(0xFF01204E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 179),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.025,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.025,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37.0),
                  child: Column(
                    children: [
                      Container(
                        width: 356,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFC19A6B)),
                        ),
                        child: const Center(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.025,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 356,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFC19A6B)),
                        ),
                        child: const Center(
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.025,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 284,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC19A6B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to Dashboard
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.025,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                  'Don’t have an account?',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 0.025,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 284,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC19A6B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to Create Account
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.025,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
