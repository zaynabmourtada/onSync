import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'api_service.dart';
import 'hours.dart';
import 'minutes.dart';
import 'am_pm.dart';

final logger = Logger();

class CoffeeMachineScreen extends StatefulWidget {
  final ApiService apiService;

  const CoffeeMachineScreen({super.key, required this.apiService});

  @override
  ScheduleInterface createState() => ScheduleInterface();
}

class ScheduleInterface extends State<CoffeeMachineScreen>
    with SingleTickerProviderStateMixin {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  bool _isAm = true;
  String _status = "OFF";

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _steamAnimation;
  late Animation<double> _steamOpacity;

  @override
  void initState() {
    super.initState();
    _getStatus();

    // Initialize the AnimationController and Animations
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _steamAnimation = Tween<double>(begin: 0.0, end: -70.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _steamOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Save scheduled time
  void _saveSelectedTime() async {
    String startTime =
        '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')} ${_isAm ? 'AM' : 'PM'}';
    String endTime = 'N/A'; // Assuming you don't have an end time in this example

    String username = 'current_user'; // Replace with actual username

    logger.i('Saving schedule for $username: $startTime to $endTime');

    try {
      final response =
          await widget.apiService.setSchedule(username, startTime, endTime);

      if (response.statusCode == 200) {
        logger.i('Schedule saved successfully');
      } else {
        logger.e('Failed to save schedule: ${response.body}');
      }
    } catch (e) {
      logger.e('Error saving schedule: $e');
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
      logger.e('Error fetching status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01204E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF01204E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 243, 240, 237)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => _onSelected(context, item),
            icon: const Icon(Icons.more_vert, color: Color.fromARGB(255, 243, 241, 239)),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.hourglass_full_rounded, color: Color(0xFFC19A6B)),
                    SizedBox(width: 10),
                    Text('Set Schedule'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
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
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xFFC19A6B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Coffee Machine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'is',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _status,
                  style: TextStyle(
                    color: _status == 'ON' ? Color.fromARGB(255, 15, 100, 17) : _status == 'OFF' ? Colors.red : Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_status == 'ON') ...[
                  const SizedBox(height: 20),
                  const Icon(Icons.coffee_maker, color: Colors.brown, size: 100),
                ] else if (_status == 'BREWING') ...[
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Steam icons
                          Transform.translate(
                            offset: Offset(0, _steamAnimation.value),
                            child: Opacity(
                              opacity: _steamOpacity.value,
                              child: const Icon(Icons.grain, color: Colors.white, size: 30),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(-20, _steamAnimation.value),
                            child: Opacity(
                              opacity: _steamOpacity.value,
                              child: const Icon(Icons.grain, color: Colors.white, size: 20),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(20, _steamAnimation.value),
                            child: Opacity(
                              opacity: _steamOpacity.value,
                              child: const Icon(Icons.grain, color: Colors.white, size: 25),
                            ),
                          ),
                          // Coffee cup icon with padding above it
                          Column(
                            children: [
                              const SizedBox(height: 40), // Adjust this value to lower the cup as needed
                              Transform.scale(
                                scale: _scaleAnimation.value,
                                child: const Icon(Icons.local_cafe, color: Colors.brown, size: 100),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
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
                            _selectedHour = index + 1; // Corrected
                          });
                        },
                        itemExtent: 50,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 12,
                          builder: (context, index) {
                            return MyHours(hours: index + 1);
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
                            _selectedMinute = index; // Corrected
                          });
                        },
                        itemExtent: 50,
                        perspective: 0.005,
                        diameterRatio: 1.2,
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 60,
                          builder: (context, index) {
                            return MyMinutes(mins: index);
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
  }
}