import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<void> setSchedule(String startTime, String endTime) async {
    final url = Uri.parse('$baseUrl/set_schedule');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'start_time': startTime,
        'end_time': endTime,
      }),
    );

    if (response.statusCode == 200) {
      print('Schedule set successfully');
    } else {
      print('Failed to set schedule');
    }
  }

  Future<void> controlCoffeeMachine(String command) async {
    final url = Uri.parse('$baseUrl/control_coffee_machine');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': command}),
    );

    if (response.statusCode == 200) {
      print('Command sent successfully');
    } else {
      print('Failed to send command');
    }
  }

  Future<Map<String, dynamic>> getStatus() async {
    final url = Uri.parse('$baseUrl/get_status');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get status');
    }
  }
}
