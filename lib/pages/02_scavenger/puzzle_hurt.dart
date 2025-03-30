import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);
  static const Color lsuCorpPurple = Color(0xFF3C1053);

  bool _isNavRailExtended = false;
  final TextEditingController _answerController = TextEditingController();
  bool _isCorrect = false;
  bool _hasChecked = false;
  String _hint = "";

  static const String correctAnswer = "BENGALBOTS";
  static const String hintText = "Hint: Look for the puzzle pieces in the hallway. The answer might be there!";

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    setState(() {
      _hasChecked = true;
      if (_answerController.text.trim().toLowerCase() == correctAnswer.toLowerCase()) {
        _isCorrect = true;
        // Mark Puzzle Hurt as completed (index 1)
        ChallengeProgress.markCompleted(1);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Correct! Well done!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            dismissDirection: DismissDirection.horizontal,
            animation: CurvedAnimation(
              parent: const AlwaysStoppedAnimation(1),
              curve: Curves.easeInOut,
            ),
          ),
        );
      } else {
        _isCorrect = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Try again!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            dismissDirection: DismissDirection.horizontal,
            animation: CurvedAnimation(
              parent: const AlwaysStoppedAnimation(1),
              curve: Curves.easeInOut,
            ),
          ),
        );
      }
    });
  }

  void _showHint() {
    setState(() {
      _hint = hintText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // Logo and title at the top
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: lsuPurple),
                            onPressed: () {
                              setState(() {
                                _isNavRailExtended = !_isNavRailExtended;
                              });
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                'assets/lsu_logo.png',
                                width: 150,
                                height: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 48, // Match the width of the menu button for balance
                            child: IconButton(
                              icon: const Icon(Icons.menu, color: Colors.transparent),
                              onPressed: null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Puzzle Hurt',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF461D7C),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Find the puzzle pieces in the hallway and solve the riddle',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF461D7C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        
                        // Answer input section
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _answerController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: _hasChecked
                                            ? (_isCorrect ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2))
                                            : Colors.white,
                                        border: const OutlineInputBorder(),
                                        labelText: 'Enter Answer',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.check, color: lsuPurple),
                                    onPressed: _checkAnswer,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lsuPurple,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: _showHint,
                                child: const Text('Need a Hint?'),
                              ),
                              if (_hint.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _hint,
                                    style: const TextStyle(
                                      color: Color(0xFF461D7C),
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Slide-in navigation rail when extended
          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 1, // Puzzle Hurt is index 1
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