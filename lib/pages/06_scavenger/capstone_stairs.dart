import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

class CapstoneStairs extends StatefulWidget {
  const CapstoneStairs({super.key});

  @override
  State<CapstoneStairs> createState() => _CapstoneStairsState();
}

class _CapstoneStairsState extends State<CapstoneStairs> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);
  static const Color lsuLightGold = Color(0xFFF1EEDB);
  static const Color lsuCorpPurple = Color(0xFF3C1053);

  bool _isNavRailExtended = false;
  final List<String> correctWords = ["BENGALBOTS"];
  final List<TextEditingController> _controllers = [];
  final List<bool> _isCorrect = [];
  final List<bool> _isChecked = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < correctWords.length; i++) {
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
    for (int i = 0; i < correctWords.length; i++) {
      setState(() {
        _isChecked[i] = true;
        _isCorrect[i] = _controllers[i].text.toUpperCase() == correctWords[i];
        if (!_isCorrect[i]) allCorrect = false;
      });
    }
    allCorrect ? _showClueDialog() : _showTryAgainDialog();
  }

  void _showClueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clue Revealed!'),
          content: const Text('Where in PFT can you see this clue? Head to this place next.'),
          actions: [TextButton(child: const Text('OK'), onPressed: () => Navigator.of(context).pop())],
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
          actions: [TextButton(child: const Text('OK'), onPressed: () => Navigator.of(context).pop())],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            color: lsuLightGold,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: lsuPurple),
                        onPressed: () {
                          setState(() {
                            _isNavRailExtended = !_isNavRailExtended;
                          });
                        },
                      ),
                    ),
                    const Text(
                      'Anagram Challenge',
                      style: TextStyle(
                        fontSize: 30, 
                        fontWeight: FontWeight.w800, 
                        color: lsuCorpPurple
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Wooden rails and hidden signs\nA scrambled word between the lines\nLook to the side, don’t miss your cue\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, fontSize: 20, color: lsuCorpPurple),
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Unscramble the word to reveal the clue:', 
                      style: TextStyle(
                        fontSize: 15, 
                        color: lsuCorpPurple, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: ListView.builder(
                          itemCount: correctWords.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: TextField(
                                        controller: _controllers[index],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: 'Enter word',
                                          border: const OutlineInputBorder(),
                                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: lsuCorpPurple)),
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lsuGold, width: 2.0)),
                                          errorStyle: const TextStyle(color: Colors.red),
                                        ),
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  if (_isChecked[index])
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: _isCorrect[index] ? const Icon(Icons.check_circle, color: Colors.green, size: 28) : const Icon(Icons.cancel, color: Colors.red, size: 28),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _checkAnswer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), 
                        backgroundColor: lsuGold, 
                        foregroundColor: lsuPurple),
                      child: const Text(
                        'Check Answer', 
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 7,
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