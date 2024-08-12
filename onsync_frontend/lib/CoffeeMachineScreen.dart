import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'api_service.dart';
import 'hours.dart';
import 'minutes.dart';
import 'am_pm.dart';

class CoffeeMachineScreen extends StatefulWidget {
  final ApiService apiService;

  const CoffeeMachineScreen({super.key, required this.apiService});

  @override
  ScheduleInterface createState() => ScheduleInterface();
}

class ScheduleInterface extends State<CoffeeMachineScreen> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  bool _isAm = true;
  String _status = "OFF"; // Add status tracking

  final log = Logger('CoffeeMachineScreen');

  @override
  void initState() {
    super.initState();
    _getStatus(); // Fetch status when the screen loads
  }

  // Save scheduled time
  void _saveSelectedTime() async {
    String startTime =
        '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')} ${_isAm ? 'AM' : 'PM'}';
    String endTime =
        'N/A'; // Assuming you don't have an end time in this example

    String username = 'current_user'; // Replace with actual username

    log.info('Saving schedule for $username: $startTime to $endTime'); // Use logger instead of print

    try {
      final response =
          await widget.apiService.setSchedule(username, startTime, endTime);

      if (response.statusCode == 200) {
        log.info('Schedule saved successfully');
      } else {
        log.warning('Failed to save schedule: ${response.body}');
      }
    } catch (e) {
      log.severe('Error saving schedule: $e');
    }
  }

  // Get coffee machine status
  Future<void> _getStatus() async {
    try {
      final status = await widget.apiService.getStatus();
      setState(() {
        _status = status['status'];
      });
    } catch (e) {
      log.severe('Error fetching status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Machine'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.hourglass_full_rounded,
                color: Color(0xFFC19A6B),
                size: 40,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF01204E),
                      content: SizedBox(
                        height: 287,
                        width: 430,
                        child: Column(
                          children: [
                            const SizedBox(height: 90),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Hours
                                Container(
                                  width: 70,
                                  height: 85,
                                  color: const Color(0xFFC19A6B),
                                  child: ListWheelScrollView.useDelegate(
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _selectedHour =
                                            index + 1; // Adjust for 1-12 range
                                      });
                                    },
                                    itemExtent: 50,
                                    perspective: 0.005,
                                    diameterRatio: 1.2,
                                    physics: const FixedExtentScrollPhysics(),
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount: 12,
                                      builder: (context, index) {
                                        return MyHours(
                                          hours: index +
                                              1, // Adjust to display 1-12 hours
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Minutes
                                Container(
                                  width: 70,
                                  height: 85,
                                  color: const Color(0xFFC19A6B),
                                  child: ListWheelScrollView.useDelegate(
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _selectedMinute = index;
                                      });
                                    },
                                    itemExtent: 50,
                                    perspective: 0.005,
                                    diameterRatio: 1.2,
                                    physics: const FixedExtentScrollPhysics(),
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount: 60,
                                      builder: (context, index) {
                                        return MyMinutes(
                                          mins: index,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // AM and PM
                                Container(
                                  width: 70,
                                  height: 85,
                                  color: const Color(0xFFC19A6B),
                                  child: ListWheelScrollView.useDelegate(
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _isAm = index == 0;
                                      });
                                    },
                                    itemExtent: 50,
                                    perspective: 0.005,
                                    diameterRatio: 1.2,
                                    physics: const FixedExtentScrollPhysics(),
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount: 2,
                                      builder: (context, index) {
                                        if (index == 0) {
                                          return AM_PM(isItAm: true);
                                        } else {
                                          return AM_PM(isItAm: false);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const SizedBox(width: 25),
                                  // Cancel Button
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFFCDCDCD),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  // Save Button
                                  ElevatedButton(
                                    onPressed: () {
                                      _saveSelectedTime();
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFC19A6B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getStatus,
              child: const Text('Refresh Status'),
            ),
            const SizedBox(height: 20),
            Text('Current Status: $_status'),
          ],
        ),
      ),
    );
  }
}
