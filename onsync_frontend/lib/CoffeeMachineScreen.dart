import 'package:flutter/material.dart';
import 'api_service.dart';
import 'hours.dart';
import 'minutes.dart';
import 'am_pm.dart';

class CoffeeMachineScreen extends StatefulWidget {
  final ApiService apiService;

  const CoffeeMachineScreen({Key? key, required this.apiService})
      : super(key: key);

  @override
  ScheduleInterface createState() => ScheduleInterface();
}

class ScheduleInterface extends State<CoffeeMachineScreen> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  bool _isAm = true;
  String _status = "OFF"; // Add status tracking

  // Save scheduled time
  void _saveSelectedTime() async {
    String startTime =
        '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')} ${_isAm ? 'AM' : 'PM'}';
    String endTime = 'N/A'; // Assuming you don't have an end time in this example

    String username = 'current_user'; // Replace with actual username

    print('Saving schedule for $username: $startTime to $endTime'); // Debug print

    try {
      final response =
          await widget.apiService.setSchedule(username, startTime, endTime);

      if (response.statusCode == 200) {
        print('Schedule saved successfully');
      } else {
        print('Failed to save schedule: ${response.body}');
      }
    } catch (e) {
      print('Error saving schedule: $e');
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
      print('Error fetching status: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getStatus(); // Fetch status when the screen loads
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF01204E), // Dark blue outer layer background
    appBar: AppBar(
      title: Text(
        'Home Page',
        style: TextStyle(color:Color(0xFFC19A6B)), // Set the title text to white
      ),
      backgroundColor: Color(0xFF01204E), // Match app bar color to the outer background
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color(0xFFC19A6B)), // Back arrow in beige
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous screen
        },
      ),
      actions: [
        PopupMenuButton<int>(
          onSelected: (item) => _onSelected(context, item),
          icon: Icon(Icons.more_vert, color: Color(0xFFC19A6B)), // Menu icon in beige
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.hourglass_full_rounded, color: Color(0xFFC19A6B)),
                  SizedBox(width: 10),
                  Text('Set Schedule'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.refresh, color: Color(0xFFC19A6B)),
                  SizedBox(width: 10),
                  Text('Refresh Status'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85, // Width of the inner layer
        height: MediaQuery.of(context).size.height * 0.85, // Height of the inner layer
        decoration: BoxDecoration(
          color: Color(0xFFC19A6B), // Beige inner layer
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Coffee Machine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'is',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'OFF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        _showTimerDialog(context);
        break;
      case 1:
        _getStatus();
        break;
    }
  }

  void _showTimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF01204E),
          content: Container(
            height: 287,
            width: 430,
            child: Column(
              children: [
                SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hours
                    Container(
                      width: 70,
                      height: 85,
                      color: Color(0xFFC19A6B),
                      child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedHour = index + 1; // Adjust for 1-12 range
                          });
                        },
                        itemExtent: 50,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 12,
                          builder: (context, index) {
                            return MyHours(
                              hours: index + 1, // Adjust to display 1-12 hours
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Minutes
                    Container(
                      width: 70,
                      height: 85,
                      color: Color(0xFFC19A6B),
                      child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMinute = index;
                          });
                        },
                        itemExtent: 50,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 60,
                          builder: (context, index) {
                            return MyMinutes(
                              mins: index,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // AM and PM
                    Container(
                      width: 70,
                      height: 85,
                      color: Color(0xFFC19A6B),
                      child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _isAm = index == 0;
                          });
                        },
                        itemExtent: 50,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
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
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(width: 25),
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
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFCDCDCD),
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          _saveSelectedTime();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC19A6B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
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
  }
}
