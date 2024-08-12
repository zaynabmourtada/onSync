import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'settings.dart';
import 'coffeemachinescreen.dart';
import 'Login.dart';

class Dashboard extends StatefulWidget {
  final ApiService apiService;
  final Map<String, dynamic> userInfo;

  const Dashboard({super.key, required this.apiService, required this.userInfo});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _allowAllNotifications = false;
  bool _notifyWhenProcessing = false;
  bool _notifyWhenReady = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Function to load saved preferences
  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _allowAllNotifications = prefs.getBool('allowAllNotifications') ?? false;
      _notifyWhenProcessing = prefs.getBool('notifyWhenProcessing') ?? false;
      _notifyWhenReady = prefs.getBool('notifyWhenReady') ?? false;
    });
  }

  // Function to save preferences
  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('allowAllNotifications', _allowAllNotifications);
    await prefs.setBool('notifyWhenProcessing', _notifyWhenProcessing);
    await prefs.setBool('notifyWhenReady', _notifyWhenReady);
  }

  // Function to show the notification preferences dialog
  void _showNotificationPreferences(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationPreferencesDialog(
          allowAllNotifications: _allowAllNotifications,
          notifyWhenProcessing: _notifyWhenProcessing,
          notifyWhenReady: _notifyWhenReady,
          onSave: (preferences) {
            setState(() {
              _allowAllNotifications = preferences['allowAllNotifications']!;
              _notifyWhenProcessing = preferences['notifyWhenProcessing']!;
              _notifyWhenReady = preferences['notifyWhenReady']!;
            });
            _savePreferences(); // Save the preferences after updating the state
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01204E),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(35.0),
            ),
            child: Container(
              height: 291.0,
              color: const Color(0xFFC19A6B),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow icon
                    const SizedBox(
                      width: 48,
                      height: 40,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.brown,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // 'Hi, user' Text
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        'Hi, ${widget.userInfo['username']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: SizedBox(
                        width: 37,
                        height: 37,
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.brown,
                            size: 40,
                          ),
                          onPressed: () {
                            _showNotificationPreferences(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 50),
                child: Wrap(
                  spacing: 20.0, // Space between the boxes horizontally
                  runSpacing: 60.0, // Space between the boxes vertically
                  children: [
                    // COFFEE MACHINE
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: const Color(0xFFC19A6B), width: 5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoffeeMachineScreen(apiService: widget.apiService),
                              ),
                            );
                          },
                          // "Coffee Machine" Text
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 70.0),
                                child: Text(
                                  "Coffee Machine",
                                  style: TextStyle(
                                    color: Color(0xFF2A9FD1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Coffee machine icon
                              Container(
                                width: 75,
                                height: 69,
                                alignment: Alignment.centerRight,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(0, 81, 227, 1),
                                      Color.fromRGBO(10, 223, 244, 1),
                                    ],
                                  ).createShader(bounds),
                                  child: const Icon(
                                    Icons.coffee_outlined,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SPRINKLER SYSTEM
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: const Color(0xFFC19A6B), width: 5),
                        ),
                        // "Sprinkler System" Text
                        child: Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 70.0),
                              child: Text(
                                "Sprinkler System",
                                style: TextStyle(
                                  color: Color(0xFF2A9FD1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Sprinkler System icon
                            Container(
                              width: 75,
                              height: 69,
                              alignment: Alignment.centerRight,
                              child: ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(0, 81, 227, 1),
                                    Color.fromRGBO(10, 223, 244, 1),
                                  ],
                                ).createShader(bounds),
                                child: const Icon(
                                  Icons.water_drop_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SETTINGS
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: const Color(0xFFC19A6B), width: 5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _showNotificationPreferences(context);
                          },
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 85.0, left: 22.5),
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                    color: Color(0xFF2A9FD1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Settings icon
                              Positioned(
                                top: 25,
                                right: 28,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(0, 81, 227, 1),
                                      Color.fromRGBO(10, 223, 244, 1),
                                    ],
                                  ).createShader(bounds),
                                  child: const Icon(
                                    Icons.settings_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ACCOUNT
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: const Color(0xFFC19A6B), width: 5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: const Text('Account Information',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      backgroundColor: const Color(0xFF01204E),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      content: Container(
                                          width: 300,
                                          height: 150,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Username
                                                const Text(
                                                  'Username:',
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 194,
                                                  height: 26,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: widget.userInfo['username'],
                                                    decoration: InputDecoration(
                                                      hintStyle: const TextStyle(color: Colors.white70),
                                                      filled: true,
                                                      fillColor: Colors.white24,
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                    ),
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                // Password
                                                const Text(
                                                  'Password:',
                                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 194,
                                                  height: 26,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue: widget.userInfo['password'],
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      hintStyle: const TextStyle(color: Colors.white70),
                                                      filled: true,
                                                      fillColor: Colors.white24,
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                    ),
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ])));
                                });
                          },
                          // "Account Text"
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 85.0, left: 22.5),
                                child: Text(
                                  "Account",
                                  style: TextStyle(
                                    color: Color(0xFF2A9FD1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Positioned(
                                top: 25,
                                right: 28,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(0, 81, 227, 1),
                                      Color.fromRGBO(10, 223, 244, 1),
                                    ],
                                  ).createShader(bounds),
                                  child: const Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // LOGOUT
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 200, bottom: 25),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF01204E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      content: Container(
                        width: 300,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Are you sure you want to logout?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen(apiService: widget.apiService,)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFC19A6B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
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
                                        color: Color(0xFFCDCDCD)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationPreferencesDialog extends StatefulWidget {
  final bool allowAllNotifications;
  final bool notifyWhenProcessing;
  final bool notifyWhenReady;
  final Function(Map<String, bool>) onSave;

  const NotificationPreferencesDialog({
    required this.allowAllNotifications,
    required this.notifyWhenProcessing,
    required this.notifyWhenReady,
    required this.onSave,
  });

  @override
  _NotificationPreferencesDialogState createState() => _NotificationPreferencesDialogState();
}

class _NotificationPreferencesDialogState extends State<NotificationPreferencesDialog> {
  late bool _allowAllNotifications;
  late bool _notifyWhenProcessing;
  late bool _notifyWhenReady;

  @override
  void initState() {
    super.initState();
    _allowAllNotifications = widget.allowAllNotifications;
    _notifyWhenProcessing = widget.notifyWhenProcessing;
    _notifyWhenReady = widget.notifyWhenReady;
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFFC19A6B),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF0C2340),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      title: const Text(
        "Notifications",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildSwitchTile("Allow All Notifications", _allowAllNotifications, (bool value) {
            setState(() {
              _allowAllNotifications = value;
            });
          }),
          _buildSwitchTile("Notify only when machine is processing", _notifyWhenProcessing, (bool value) {
            setState(() {
              _notifyWhenProcessing = value;
            });
          }),
          _buildSwitchTile("Notify only when machine is ready", _notifyWhenReady, (bool value) {
            setState(() {
              _notifyWhenReady = value;
            });
          }),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC19A6B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () {
            widget.onSave({
              'allowAllNotifications': _allowAllNotifications,
              'notifyWhenProcessing': _notifyWhenProcessing,
              'notifyWhenReady': _notifyWhenReady,
            });
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            "Save Preferences",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
