import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';

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
    if (allCorrect) {
      // Mark Capstone Stairs as completed (index 5)
      ChallengeProgress.markCompleted(5);
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
        children: <Widget>[
          // Main content
          Container(
            color: lsuLightGold,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                     Container
                     (
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
                    Expanded
                    ( 
                          child: Column
                          (
                            children: 
                            [
                              const Text(
                              'Anagram Challenge',
                              style: TextStyle(
                                fontSize: 35, 
                                fontWeight: FontWeight.w800, 
                                color: lsuCorpPurple, 
                              ),
                              ),
                              const SizedBox(height: 30.0),
                              const Text(
                                'Wooden rails and hidden signs,\n'
                                'a scrambled word between the lines.\n'
                                'Look to the side, don\'t miss your cue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: lsuCorpPurple, 
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              const Text(
                                'Unscramble the found letters to reveal the clue:', 
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20, 
                                  color: lsuCorpPurple, 
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              const SizedBox(height: 20.0),
                              Expanded(
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 500),
                                  child: ListView.builder(
                                    itemCount: correctWords.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                                                    hintStyle: TextStyle(
                                                      color: lsuCorpPurple,
                                                      fontStyle: FontStyle.italic,
                                                    ),
                                                    border: const OutlineInputBorder(),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: lsuCorpPurple)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: lsuGold, width: 2.0)),
                                                    errorStyle: const TextStyle(color: Colors.red),
                                                  ),
                                                  style: const TextStyle(color: lsuCorpPurple),
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
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _checkAnswer,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), 
                                  backgroundColor: lsuGold, 
                                  foregroundColor: lsuPurple),
                                child: const Text(
                                  'Check Answer', 
                                  style: TextStyle(
                                    fontSize: 20, 
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ),
                              SizedBox(height:20),
                              if(ChallengeProgress.isCompleted(10) == true)
                              Text
                              (
                                style: TextStyle
                                (
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                                "s"
                              )
                            ],
                          )
                      
                    )
                    
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
                selectedIndex: 5, 
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