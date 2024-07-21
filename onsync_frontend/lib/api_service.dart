import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';

class ApiService {
  static const String baseUrl =
      'https://192.168.6.215:8000'; // Update to your machine's IP address

  final Logger _logger = Logger('ApiService');

  Future<void> sendCommand(String command) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/control_coffee_machine/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'command': command}),
      );

      if (response.statusCode == 200) {
        _logger.info("Command sent: $command");
      } else {
        _logger.severe("Failed to send command: ${response.body}");
      }
    } catch (e) {
      _logger.severe("Error sending command: $e");
    }
  }
}
