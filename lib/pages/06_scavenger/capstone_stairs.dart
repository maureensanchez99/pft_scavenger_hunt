import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

class CapstoneStairs extends StatefulWidget {
  const CapstoneStairs({super.key});

  @override
  State<CapstoneStairs> createState() => _CapstoneStairsState();
}

class _CapstoneStairsState extends State<CapstoneStairs> with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  late AnimationController _animationController;
  
  // State for nav rail
  bool _isNavRailExtended = false;
  
  final List<String> correctWords = [
    "BENGALBOTS",
  ];

  final List<String> scrambledWords = [
    "GALBENTBOS",
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
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _animationController.dispose();
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
      body: Stack(
        children: [
          // Main content
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(lsuGold, lsuPurple, _animationController.value) ?? lsuGold,
                      Color.lerp(lsuPurple, lsuGold, _animationController.value) ?? lsuPurple,
                    ],
                  ),
                ),
                child: Column(
                  children: [
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: _checkAnswer,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: lsuGold,
                                      foregroundColor: lsuPurple,
                                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    ),
                                    child: const Text(
                                      'Check Answer',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          // Slide-in navigation rail when extended
          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 5, // Capstone Stairs is index 5
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