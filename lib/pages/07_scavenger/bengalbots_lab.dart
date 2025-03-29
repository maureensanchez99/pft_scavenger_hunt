import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

class BengalbotsLab extends StatefulWidget {
  const BengalbotsLab({super.key});

  @override
  State<BengalbotsLab> createState() => _BengalbotsLabState();
}

class _BengalbotsLabState extends State<BengalbotsLab> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);
  static const Color lsuCorpPurple = Color(0xFF3C1053);

  final List<String> answerValue = ["132"];
  final List<TextEditingController> _controllers = [];
  final List<bool> _isCorrect = [];
  final List<bool> _isChecked = [];
  
  // State for nav rail
  bool _isNavRailExtended = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < answerValue.length; i++) {
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
    for (int i = 0; i < answerValue.length; i++) {
      setState(() {
        _isChecked[i] = true;
        _isCorrect[i] = _controllers[i].text.toUpperCase() == answerValue[i];
        if (!_isCorrect[i]) allCorrect = false;
      });
    }
    if (!allCorrect) {
      _showTryAgainDialog();
    }
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Try Again!'),
          content: const Text('The answer is incorrect.'),
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
            color: lsuPurple,
            child: Column(
              children: [
                Container(
                  color: lsuGold,
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Image.asset(
                      'assets/lsu_logo.png',
                      width: 150,
                      height: 75,
                    ),
                  ),
                ),
                // Hamburger menu at the top left
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.menu, color: lsuCorpPurple),
                      onPressed: () {
                        setState(() {
                          _isNavRailExtended = !_isNavRailExtended;
                        });
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Hidden Value Challenge',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35, 
                              fontWeight: FontWeight.w800, 
                              color: lsuGold,
                            ),
                          ),
                          SizedBox(height:20.0),
                          const Text(
                            'Find the clue that is hidden in sight. '
                            'A vessel floats, but here’s the key—\n'
                            'It comes with a measure, marked in g. '
                            'Seek the ship, don’t drift away!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: lsuGold,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: answerValue.length,
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
                                              hintText: 'Enter value',
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              border: const OutlineInputBorder(),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lsuGold, width: 2.0)),
                                              errorStyle: const TextStyle(color: Colors.red),
                                            ),
                                            style: const TextStyle(color: Colors.white),
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
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _checkAnswer,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                              backgroundColor: lsuGold,
                              foregroundColor: lsuPurple,
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

          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 6, 
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