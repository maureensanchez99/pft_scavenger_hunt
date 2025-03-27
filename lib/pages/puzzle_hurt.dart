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
  static const List<String> correctAnswers = ["Ts8", "92p", "fT4"];

  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());
  final List<String> _hints = [
    "Hint 1: Check outside the ME office. Check around the tables. Sit down, maybe you'll see it.",
    "Hint 2: Go where CSC students beg for help. Look outside, maybe the sun will heal you. Don't forget to check the windows.",
    "Hint 3: Located around the 3300 offices. Look at the office plaques, they'll might be there. :>"
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
      body: SingleChildScrollView(
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
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
