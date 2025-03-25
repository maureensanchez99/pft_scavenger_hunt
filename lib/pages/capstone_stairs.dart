import 'package:flutter/material.dart';
import 'bengalbots_lab.dart';

class CapstoneStairs extends StatefulWidget {
  const CapstoneStairs({super.key});

  @override
  State<CapstoneStairs> createState() => _CapstoneStairsState();
}

class _CapstoneStairsState extends State<CapstoneStairs> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold

  final List<String> scrambledWords = [
    "BOGTBLEANS",
  ];

  final List<String> correctWords = [
    "BENGALBOTS",
  ];

  final List<TextEditingController> _controllers = [];
  final List<bool> _isCorrect = [];
  final List<bool> _isChecked = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < scrambledWords.length; i++) {
      _controllers.add(TextEditingController());
      _isCorrect.add(false);
      _isChecked.add(false);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _checkAnswer() {
    bool allCorrect = true;
    for (int i = 0; i < scrambledWords.length; i++) {
      setState(() {
        _isChecked[i] = true;
        if (_controllers[i].text.toUpperCase() == correctWords[i]) {
          _isCorrect[i] = true;
        } else {
          _isCorrect[i] = false;
          allCorrect = false;
        }
      });
    }

    if (allCorrect) {
      _showClueDialog();
    } else {
      _showTryAgainDialog();
    }
  }

  void _showClueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clue Revealed!'),
          content: const Text(
            'Where in PFT can you see this clue? Head to this place next.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Try Again!'),
          content: const Text('The word is incorrect.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lsuGold,
        foregroundColor: lsuPurple,
        title: const Text(
          'Anagram Challenge',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: lsuPurple, // Static background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Unscramble the word to reveal the clue:',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: ListView.builder(
                      itemCount: scrambledWords.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                    controller: _controllers[index],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                      hintText: 'Enter word',
                                      hintStyle: const TextStyle(color: Colors.white54),
                                      border: const OutlineInputBorder(),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white70),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: lsuGold, width: 2.0),
                                      ),
                                      errorStyle: const TextStyle(color: Colors.red),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              if (_isChecked[index])
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: _isCorrect[index]
                                      ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
                                      : const Icon(Icons.cancel, color: Colors.red, size: 28),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    backgroundColor: lsuGold,
                    foregroundColor: lsuPurple,
                  ),
                  child: const Text(
                    'Check Answer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}