import 'package:flutter/material.dart';
import 'Settings.dart';
import 'CoffeeMachineScreen.dart';
import 'LogoutScreen.dart';
import 'Account.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01204E),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35.0),
            ),
            child: Container(
              height: 291.0,
              color: const Color(0xFFC19A6B),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow icon
                    Container(
                      width: 48,
                      height: 40,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.brown,
                        size: 40,
                      ),
                    ),

                    // 'Hi, user' Text
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        'Hi, user',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),

                    // Notification icon
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Container(
                        width: 37,
                        height: 37,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.brown,
                          size: 40,
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
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border:
                              Border.all(color: Color(0xFFC19A6B), width: 5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoffeeMachineScreen()),
                            );
                          },

                          // "Coffee Machine" Text
                          child: Stack(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 70.0),
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
                                shaderCallback: (bounds) => LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(0, 81, 227, 1),
                                    Color.fromRGBO(10, 223, 244, 1),
                                  ],
                                ).createShader(bounds),
                                child: Icon(
                                  Icons.coffee_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),

                    // SPRINKLER SYSTEM
                    SizedBox(width: 20),
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border:
                              Border.all(color: Color(0xFFC19A6B), width: 5),
                        ),

                        // "Sprinkler System" Text
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 70.0),
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
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(0, 81, 227, 1),
                                  Color.fromRGBO(10, 223, 244, 1),
                                ],
                              ).createShader(bounds),
                              child: Icon(
                                Icons.water_drop_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),

                    // SETTINGS
                    SizedBox(width: 20),
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border:
                              Border.all(color: Color(0xFFC19A6B), width: 5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()),
                            );
                          },

                          // "Settings Text"
                          child: Stack(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 85.0, left: 22.5),
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
                                shaderCallback: (bounds) => LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(0, 81, 227, 1),
                                    Color.fromRGBO(10, 223, 244, 1),
                                  ],
                                ).createShader(bounds),
                                child: Icon(
                                  Icons.settings_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),

                    // ACCOUNT
                    SizedBox(width: 20),
                    SizedBox(
                      width: 130,
                      height: 170,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border:
                              Border.all(color: Color(0xFFC19A6B), width: 5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Account()),
                            );
                          },

                          // "Account Text"
                          child: Stack(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 85.0, left: 22.5),
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

                            // Account icon
                            Positioned(
                              top: 25,
                              right: 25,
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(0, 81, 227, 1),
                                    Color.fromRGBO(10, 223, 244, 1),
                                  ],
                                ).createShader(bounds),
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // LOGOUT
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 200, bottom: 25),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutScreen()),
                );
              },
              child: Text(
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
