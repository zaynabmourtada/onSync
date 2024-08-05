import 'package:flutter/material.dart';
import 'notifpreferences.dart'; // Ensure the path is correct

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return NotifPreferences();
              },
            );
          },
          child: Text('Show Notification Preferences'),
        ),
      ),
    );
  }
}
