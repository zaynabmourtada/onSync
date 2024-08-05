import 'package:flutter/material.dart';

class NotificationPreferences extends StatefulWidget {
  const NotificationPreferences({super.key});

  @override
  _NotificationPreferencesState createState() => _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  bool allowAllNotifications = false;
  bool notifyWhenProcessing = false;
  bool notifyWhenReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F54), // Dark blue background color
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF001F54),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            buildSwitch('Allow All Notifications', allowAllNotifications, (value) {
              setState(() {
                allowAllNotifications = value;
              });
            }),
            buildSwitch('Notify only when machine is processing', notifyWhenProcessing, (value) {
              setState(() {
                notifyWhenProcessing = value;
              });
            }),
            buildSwitch('Notify only when machine is ready', notifyWhenReady, (value) {
              setState(() {
                notifyWhenReady = value;
              });
            }),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save preferences logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text(
                  'Save Preferences',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class NotifPreferences extends StatefulWidget {
  const NotifPreferences({super.key});

  @override
  _NotifPreferencesState createState() => _NotifPreferencesState();
}

class _NotifPreferencesState extends State<NotifPreferences> {
  bool allowAllNotifications = false;
  bool notifyWhenProcessing = false;
  bool notifyWhenReady = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF01204E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Notifications',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text(
              'Allow All Notifications',
              style: TextStyle(color: Colors.white),
            ),
            value: allowAllNotifications,
            onChanged: (bool value) {
              setState(() {
                allowAllNotifications = value;
              });
            },
            secondary: Icon(
              allowAllNotifications ? Icons.notifications_active : Icons.notifications_off,
              color: Colors.white,
            ),
          ),
          SwitchListTile(
            title: const Text(
              'Notify only when machine is processing',
              style: TextStyle(color: Colors.white),
            ),
            value: notifyWhenProcessing,
            onChanged: (bool value) {
              setState(() {
                notifyWhenProcessing = value;
              });
            },
            secondary: Icon(
              notifyWhenProcessing ? Icons.notifications_active : Icons.notifications_off,
              color: Colors.white,
            ),
          ),
          SwitchListTile(
            title: const Text(
              'Notify only when machine is ready',
              style: TextStyle(color: Colors.white),
            ),
            value: notifyWhenReady,
            onChanged: (bool value) {
              setState(() {
                notifyWhenReady = value;
              });
            },
            secondary: Icon(
              notifyWhenReady ? Icons.notifications_active : Icons.notifications_off,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC19A6B), // Correct parameter
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Save Preferences',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
