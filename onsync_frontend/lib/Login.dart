import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF01204E),
      body: Center(
        child: Container(
          width: 430,
          height: 932,
          margin: EdgeInsets.only(top: 1977, left: -298),
          decoration: BoxDecoration(
            color: Color(0xFF01204E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 179),
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.025,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.025,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37.0),
                child: Column(
                  children: [
                    Container(
                      width: 356,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFC19A6B)),
                      ),
                      child: Center(
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
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 356,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFC19A6B)),
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
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 284,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0xFFC19A6B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigate to Dashboard
                  },
                  child: Text(
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
              SizedBox(height: 80),
              Center(
                child: Text(
                  'Don’t have an account?',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 0.025,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 284,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0xFFC19A6B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigate to Create Account
                  },
                  child: Text(
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
    );
  }
}
