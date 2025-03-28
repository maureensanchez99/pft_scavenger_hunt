import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';

class ChevronCenter extends StatefulWidget {
  const ChevronCenter({super.key});

  @override
  State<ChevronCenter> createState() => _ChevronCenterState();
}

class _ChevronCenterState extends State<ChevronCenter> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  // State variables
  bool _isNavRailExtended = false;
  final TextEditingController _answerController = TextEditingController();
  bool _isCorrect = false;
  bool _hasChecked = false;
  String _hint = "";
  
  static const String correctAnswer = "ZEBSOLK";
  static const String hintText = "Hint: Look for the 3D printer in the Chevron Center. The answer might be printed there!";

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
        // Mark Chevron Center as completed (index 8)
        ChallengeProgress.markCompleted(8);
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

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You found the correct answer! Move on to the next location.'),
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
          content: const Text('That\'s not the correct answer. Keep looking!'),
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

  void _openImageFullScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(0),
              minScale: 1.0,
              maxScale: 3.0,
              child: Image.asset('assets/chevron_center.jpg', fit: BoxFit.contain),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
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
                        'Chevron Center',
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
                          'The man in the photo is looking at a printer that makes objects. What you\'re looking for will be there',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF461D7C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        
                        // Image section
                        GestureDetector(
                          onTap: () => _openImageFullScreen(context),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/chevron_center.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                color: Colors.black54,
                                child: const Text(
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
                selectedIndex: 8, // Chevron Center is index 8
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