import 'package:flutter/material.dart';
import 'registration.dart';
import 'Login.dart';
import 'confirmation_message.dart';
import 'error_message.dart'; // Import the login.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFC19A6B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC19A6B),
          primary: const Color(0xFFC19A6B),
          secondary: const Color(0xFF01204E),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/registration',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isValid = true; // Change this to false to show error message
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF0A0E21),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: isValid ? ConfirmationMessage() : ErrorMessage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/registration'),
              child: Text('Register'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDialog,
              child: Text('Show Dialog'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
