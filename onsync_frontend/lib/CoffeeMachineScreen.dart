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

  // Save scheduled time
  void _saveSelectedTime() {
    String selectedTime =
        '$_selectedHour:$_selectedMinute ${_isAm ? 'AM' : 'PM'}';
    print('Selected Time: $selectedTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Machine'),
      ),
      body: Center(
        child: IconButton(
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
                                    _selectedHour = index;
                                  });
                                },
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 13,
                                  builder: (context, index) {
                                    return MyHours(
                                      hours: index,
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
          },
        ),
      ),
    );
  }
}
