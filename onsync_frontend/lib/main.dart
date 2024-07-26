import 'package:flutter/material.dart';
import 'registration.dart'; // Import the registration.dart file
import 'dashboard.dart'; 
import 'api_service.dart'; // Import the api_service.dart file
import 'Login.dart';

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
        primaryColor: const Color(0xFFC19A6B), // Setting the primary color to brown
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC19A6B), // Setting the seed color to brown
          primary: const Color(0xFFC19A6B), // Ensuring the primary color is brown
          secondary: const Color(0xFF01204E), // Setting secondary color to dark blue
        ),
        useMaterial3: true,
      ),
      initialRoute: '/registration', // Set the initial route to the RegistrationPage
      routes: {
        '/login': (context) =>  LoginScreen(), // Define the route for LoginPage
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
  final ApiService apiService = ApiService('http://192.168.1.100:5000');
  int _counter = 0;
  String _status = "OFF";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _setSchedule() async {
    await apiService.setSchedule('2024-07-21T08:00:00', '2024-07-21T08:15:00');
  }

  Future<void> _sendCommand(String command) async {
    await apiService.controlCoffeeMachine(command);
    _getStatus(); // Update status after sending command
  }

  Future<void> _getStatus() async {
    final status = await apiService.getStatus();
    setState(() {
      _status = status['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary, // Setting AppBar background to brown
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
              onPressed: _setSchedule,
              child: Text('Set Schedule'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendCommand('ON'),
              child: Text('Turn ON'),
            ),
            ElevatedButton(
              onPressed: () => _sendCommand('OFF'),
              child: Text('Turn OFF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getStatus,
              child: Text('Get Status'),
            ),
            const SizedBox(height: 20),
            Text('Current Status: $_status'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).colorScheme.primary, // Setting FloatingActionButton color to brown
        child: const Icon(Icons.add),
      ),
    );
  }
}
