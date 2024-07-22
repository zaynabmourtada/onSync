import 'package:flutter/material.dart';
import 'api_service.dart';

class CoffeeControlPage extends StatefulWidget {
  @override
  _CoffeeControlPageState createState() => _CoffeeControlPageState();
}

class _CoffeeControlPageState extends State<CoffeeControlPage> {
  final ApiService apiService = ApiService('http://192.168.1.100:5000');
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String _status = "OFF";

  Future<void> _setSchedule() async {
    await apiService.setSchedule(
        _startTimeController.text, _endTimeController.text);
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
      appBar: AppBar(title: Text('Coffee Machine Control')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _startTimeController,
              decoration: InputDecoration(
                  labelText: 'Start Time (YYYY-MM-DDTHH:MM:SS)'),
            ),
            TextField(
              controller: _endTimeController,
              decoration:
                  InputDecoration(labelText: 'End Time (YYYY-MM-DDTHH:MM:SS)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setSchedule,
              child: Text('Set Schedule'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendCommand('ON'),
              child: Text('Turn ON'),
            ),
            ElevatedButton(
              onPressed: () => _sendCommand('OFF'),
              child: Text('Turn OFF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getStatus,
              child: Text('Get Status'),
            ),
            SizedBox(height: 20),
            Text('Current Status: $_status'),
          ],
        ),
      ),
    );
  }
}
