import 'package:flutter/material.dart';
import 'dart:async';

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
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);
  static const List<String> correctAnswers = [
    "Tiger Stadium",
    "Memorial Tower",
    "Quad"
  ];

  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());
  final List<String> _hints = [
    "Hint 1: Look closely at the background",
    "Hint 2: Check the left corner",
    "Hint 3: Focus on the structure"
  ];
  final List<String> _currentHints = ["", "", ""];
  final List<Color> _inputColors = List.generate(3, (index) => Colors.white);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lsuPurple,
        title: Image.asset(
          'assets/lsu_logo_gold.png',
          width: 150,
          height: 100,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/puzzle_${index + 1}.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controllers[index],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: _inputColors[index],
                                border: OutlineInputBorder(),
                                labelText: 'Enter Answer',
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: Icon(Icons.check, color: lsuPurple),
                            onPressed: () => _checkAnswer(index),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lsuPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _showHint(index),
                        child: const Text('Hint'),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _currentHints[index],
                        style: const TextStyle(
                            fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
