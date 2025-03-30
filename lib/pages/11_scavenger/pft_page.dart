import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';

class PftPage extends StatefulWidget {
  const PftPage({super.key});

  @override
  State<PftPage> createState() => _PftPageState();
}

class _PftPageState extends State<PftPage> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  static const Color lsuCorpPurple = Color(0xFF3C1053);
  
  final List<String> phrase = ["hard work", "integrity", "guts"];
  final List<TextEditingController> _controllers = [];
  final List<bool> _isCorrect = [];
  final List<bool> _isChecked = [];

  // State for nav rail
  bool _isNavRailExtended = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < phrase.length; i++) {
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
    List<String> userAnswers = _controllers.map((controller) => controller.text.trim().toUpperCase()).toList();
    List<String> correctAnswers = phrase.map((word) => word.toUpperCase()).toList();

    userAnswers.sort();
    correctAnswers.sort();

    bool allCorrect = ListEquality().equals(userAnswers, correctAnswers);

    setState(() {
      for (int i = 0; i < _isChecked.length; i++) {
        _isChecked[i] = true;
        _isCorrect[i] = correctAnswers.contains(userAnswers[i]);
      }
    });

    if (allCorrect) {
      // Mark PFT Page as completed (index 10)
      ChallengeProgress.markCompleted(10);
      _showSuccessDialog();
    } else {
      _showTryAgainDialog();
    }
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Try Again!'),
          content: const Text('The values are incorrect.'),
          actions: [TextButton(child: const Text('OK'), onPressed: () => Navigator.of(context).pop())],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!'),
          content: const Text('You found all the correct values!'),
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
            color: lsuGold,
            child: Column(
              children: [
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

                // Hamburger menu at the top left
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
                
                // Main content
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'PFT Values',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: lsuPurple,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          const Text(
                            'Patrick F Taylor Hall did not name itself,\n'
                            'Come out and find the dedication to our alumni that we honor.\n',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: lsuPurple,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          const Text(
                            'What are the three values that he demands of us as students?', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20, 
                              color: lsuPurple, 
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          const SizedBox(height: 20),
                            Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: phrase.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: SizedBox(
                                          height: 45,
                                          child: TextField(
                                            controller: _controllers[index],
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: 'Enter value',
                                              hintStyle: TextStyle(
                                                color: lsuPurple,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              border: const OutlineInputBorder(),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: lsuPurple)),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lsuCorpPurple, width: 2.0)),
                                              errorStyle: const TextStyle(color: Colors.red),
                                            ),
                                            style: const TextStyle(color: lsuPurple),
                                          ),
                                        ),
                                      ),
                                      if (_isChecked[index])
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: _isCorrect[index] ? const Icon(
                                            Icons.check_circle, 
                                            color: Colors.green, 
                                            size: 28) : const Icon(Icons.cancel, color: Colors.red, size: 28),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _checkAnswer,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                              backgroundColor: lsuCorpPurple,
                              foregroundColor: lsuGold,
                            ),
                            child: const Text(
                              'Check Answer',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
          
          // Slide-in navigation rail when extended
          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 10, // PFT is index 10
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