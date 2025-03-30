import 'package:flutter/material.dart';
import 'dart:async';
import '../../widgets/nav_rail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle Hunt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PuzzleScreen(),
    );
  }
}

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);
  static const List<String> correctAnswers = ["Ts8", "92p", "fT4"];

  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());
  final List<String> _hints = [
    "Hint 1: Check outside the ME office. Check around the tables. Sit down, maybe you'll see it.",
    "Hint 2: Go where CSC students beg for help. Look outside, maybe the sun will heal you. Don't forget to check the windows.",
    "Hint 3: Located around the 3300 offices. Look at the office plaques, they might be there. :>"
  ];
  final List<String> _currentHints = ["", "", ""];
  final List<Color> _inputColors = List.generate(3, (index) => Colors.white);

  bool _isNavRailExtended = false;

  void _showHint(int index) {
    setState(() {
      _currentHints[index] = _hints[index];
    });
  }

  void _checkAnswer(int index) {
    setState(() {
      if (_controllers[index].text.trim().toLowerCase() ==
          correctAnswers[index].toLowerCase()) {
        _inputColors[index] = Colors.lightGreenAccent;
      } else {
        _inputColors[index] = Colors.redAccent.shade100;
        Timer(const Duration(seconds: 1), () {
          setState(() {
            _inputColors[index] = Colors.white;
          });
        });
      }
    });
  }

  void _openImageFullScreen(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(0),
              minScale: 1.0,
              maxScale: 3.0,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image and Content
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/third_floor_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // LSU Logo Title
                Container(
                  color: lsuPurple,
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Image.asset(
                      'assets/lsu_logo_gold.png',
                      width: 150,
                      height: 75,
                    ),
                  ),
                ),

                // Hamburger Menu
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.menu, color: lsuPurple),
                      onPressed: () {
                        setState(() {
                          _isNavRailExtended = !_isNavRailExtended;
                        });
                      },
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Find the Hidden Locations!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNova',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => _openImageFullScreen(
                                        context, 'assets/puzzle_${index + 1}.jpg'),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/puzzle_${index + 1}.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          color: Colors.black54,
                                          child: Text(
                                            'Click to Zoom',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: _controllers[index],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: _inputColors[index],
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Answer',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => _showHint(index),
                                    child: Text('Show Hint'),
                                  ),
                                  Text(
                                    _currentHints[index],
                                    style: TextStyle(color: Colors.grey[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Navigation Rail
          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 1, // Puzzle Hunt is index 1
                isExtended: true,
                onExtendedChange: (value) {
                  setState(() {
                    _isNavRailExtended = value;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}