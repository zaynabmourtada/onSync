import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Handle register API call
  Future<http.Response> register(
      String email, String username, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    return response;
  }

  // Handle login API call
  Future<http.Response> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    return response;
  }

  // Handle Schedule Interface API call
  Future<http.Response> setSchedule(String username,String startTime, String endTime) async {
    final url = Uri.parse('$baseUrl/set_schedule');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'start_time': startTime,
        'end_time': endTime,
      }),
    );

    return response;
  }

   Future<Map<String, dynamic>> getSchedule(String username) async {
    final url = Uri.parse('$baseUrl/get_schedule?username=$username');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch schedule');
    }
  }


  // Handle control API call
  Future<http.Response> controlCoffeeMachine(String command) async {
    final url = Uri.parse('$baseUrl/control_coffee_machine');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'command': command}),
    );

    return response;
  }

  // Handle status API call
  Future<Map<String, dynamic>> getStatus() async {
    final url = Uri.parse('$baseUrl/get_status');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get status');
    }
  }

  // Handle Account Information API call
  Future<Map<String, dynamic>> getAccountInfo() async{
    final url = Uri.parse('$baseUrl/account');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load account info');
    }
    }

  }

