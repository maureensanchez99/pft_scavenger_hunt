import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

class RoboticsRoom extends StatefulWidget {
  const RoboticsRoom({super.key});

  @override
  State<RoboticsRoom> createState() => _RoboticsRoomState();
}

class _RoboticsRoomState extends State<RoboticsRoom> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);

  // State for nav rail
  bool _isNavRailExtended = false;

  final TextEditingController _controller = TextEditingController();
  String _feedback = '';
  final String _correctAnswer = 'universal';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // Adjust height as needed
        child: Container(
          color: lsuPurple,
          child: Column(
            children: [
              Container(
                color: lsuGold,
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Image.asset(
                    'assets/lsu_logo.png',
                    width: 150,
                    height: 75,
                  ),
                ),
              ),
              Stack(
                children: [
                  // Ensures the hamburger menu appears at the top left
                   Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.menu, color: lsuGold),
                      onPressed: () {
                        setState(() {
                          _isNavRailExtended = !_isNavRailExtended;
                        });
                      },
                    ),
                  ),
                ),

                  // Title in the center
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          // Navigation rail
          if (_isNavRailExtended)
            ScavengerHuntNavRail(
              selectedIndex: 10,
              isExtended: true,
              onExtendedChange: (value) {
                setState(() {
                  _isNavRailExtended = value;
                });
              },
            ),

          // Main content
          Expanded(
            child: Container(
              color: lsuPurple,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/roboticshint.jpg'),
                          height: 180,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'In this room lies a giant robot that is so out of this world,\n'
                          'you could almost say it\'s _____',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter your answer',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white10,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (_controller.text.trim().toLowerCase() == _correctAnswer) {
                                _feedback = '✅ Correct!';
                              } else {
                                _feedback = '❌ Try again!';
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: lsuPurple,
                            backgroundColor: lsuGold,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text('Check Answer'),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _feedback,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
