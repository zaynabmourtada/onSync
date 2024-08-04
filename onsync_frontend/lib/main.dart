import 'package:flutter/material.dart';
import 'registration.dart';
import 'Login.dart';
import 'confirmation_message.dart';
import 'error_message.dart'; // Ensure you import the necessary files
import 'api_service.dart';
import 'dashboard.dart';

void main() {
  final apiService = ApiService('http://10.0.2.2:5000');

  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  const MyApp({super.key, required this.apiService});

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
        '/': (context) =>
            MyHomePage(title: 'Flutter Demo Home Page', apiService: apiService),
        '/registration': (context) => RegistrationPage(apiService: apiService),
        '/login': (context) => LoginScreen(apiService: apiService),
        '/dashboard': (context) => Dashboard(apiService: apiService),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ApiService apiService;

  const MyHomePage({super.key, required this.title, required this.apiService});

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
          backgroundColor: const Color(0xFF0A0E21),
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
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDialog,
              child: const Text('Show Dialog'),
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
