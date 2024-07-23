import 'package:flutter/material.dart';
import 'registration.dart'; // Import the registration.dart file
import 'dashboard.dart'; 

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
        primaryColor:
            const Color(0xFFC19A6B), // Setting the primary color to brown
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC19A6B), // Setting the seed color to brown
          primary:
              const Color(0xFFC19A6B), // Ensuring the primary color is brown
          secondary:
              const Color(0xFF01204E), // Setting secondary color to dark blue
        ),
        useMaterial3: true,
      ),
      initialRoute:
          '/registration', // Set the initial route to the RegistrationPage
      routes: {
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
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Setting AppBar background to brown
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Setting FloatingActionButton color to brown
        child: const Icon(Icons.add),
      ),
    );
  }
}
