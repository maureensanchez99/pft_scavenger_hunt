import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';

class JpFavSpot extends StatefulWidget {
  const JpFavSpot({super.key});

  @override
  State<JpFavSpot> createState() => _JpFavSpotState();
}

class _JpFavSpotState extends State<JpFavSpot> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  // State for nav rail
  bool _isNavRailExtended = false;
  bool finalQuestionReady = false;
  final TextEditingController _answerController = TextEditingController();
  bool _isCorrect = false;
  bool _hasChecked = false;
  
  static const String correctAnswer = "JP";

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void showFinalQuestion()
  {
    setState(() 
    {
      finalQuestionReady = true;  
    });
  }

  void _checkAnswer() {
    setState(() {
      _hasChecked = true;
      if (_answerController.text.trim().toLowerCase() == correctAnswer.toLowerCase()) {
        _isCorrect = true;
        // Mark JP's favorite spot as completed (index 11)
        ChallengeProgress.markCompleted(11);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFA39AAC)
            ),
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
                        children: 
                        [
                          if(!finalQuestionReady)
                          Column
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: 
                            [
                              Text
                              (
                                textAlign: TextAlign.center,
                                "Huh, you made it to the end?\nAre you ready for the final question then? ",
                                style: TextStyle
                                (
                                  color: Color(0xFF3C1053),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton
                              (
                                onPressed: showFinalQuestion,
                                style: ElevatedButton.styleFrom
                                (
                                  backgroundColor: Color(0xFF3C1053)
                                ),
                                child: Text
                                (
                                  textAlign: TextAlign.center,
                                  "I am Ready",
                                  style: TextStyle
                                  (
                                    color: lsuGold,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              )
                            ],
                          )
                          else
                          Column
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: 
                            [
                              Text
                              (
                                textAlign: TextAlign.center,
                                "What is JP's favorite spot?",
                                style: TextStyle
                                (
                                  color: Color(0xFF3C1053),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 500),
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
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _checkAnswer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF3C1053),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                ),
                                child: Text(
                                  'Submit Answer',
                                  style: TextStyle(
                                    color: lsuGold,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
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
                selectedIndex: 11, // JP's Favorite Spot is index 11
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