import 'package:flutter/material.dart';

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

  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());
  final List<String> _hints = [
    "Hint 1: Look closely at the background",
    "Hint 2: Check the left corner",
    "Hint 3: Focus on the structure"
  ];
  final List<String> _currentHints = ["", "", ""];

  void _showHint(int index) {
    setState(() {
      _currentHints[index] = _hints[index];
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage('assets/puzzle_${index + 1}.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: _controllers[index],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Answer',
                        ),
                      ),
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
