import 'package:flutter/material.dart';
import 'registration.dart'; // Import the registration.dart file
import 'dashboard.dart'; 
import 'api_service.dart'; // Import the api_service.dart file
import 'Login.dart';
import 'CoffeeMachineScreen.dart';
import 'registration.dart';
import 'Login.dart'; // Import the login.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/CoffeeMachineScreen': (context) => const CoffeeMachineScreen(), 

        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/registration': (context) => const RegistrationPage(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
