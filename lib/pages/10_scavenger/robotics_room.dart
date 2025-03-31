import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';

class RoboticsRoom extends StatefulWidget {
  const RoboticsRoom({super.key});

  @override
  State<RoboticsRoom> createState() => _RoboticsRoomState();
}

class _RoboticsRoomState extends State<RoboticsRoom> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);

  // State for nav rail
  bool _isNavRailExtended = false;

  final TextEditingController _controller = TextEditingController();
  String _feedback = '';
  final String _correctAnswer = 'universal';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              child: Image.asset('assets/roboticshint.jpg', fit: BoxFit.contain),
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

  void _checkAnswer() {
    if (_controller.text.trim().toLowerCase() == _correctAnswer) {
      // Mark Robotics Room as completed (index 9)
      ChallengeProgress.markCompleted(9);
      setState(() {
        _feedback = 'Correct! Well done!';
      });
    } else {
      setState(() {
        _feedback = 'Try again!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // Adjust height as needed
        child: Container(
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
                    height: 60,
                  ),
                ),
              ),
              Stack(
                children: [
                  // Ensures the hamburger menu appears at the top left
                   Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IconButton(
                      icon: const Icon(Icons.menu, color: lsuGold),
                      onPressed: () {
                        setState(() {
                          _isNavRailExtended = !_isNavRailExtended;
                        });
                      },
                    ),
                  ),
                ),

                  // Title in the center
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          // Navigation rail
          if (_isNavRailExtended)
            ScavengerHuntNavRail(
              selectedIndex: 9,
              isExtended: true,
              onExtendedChange: (value) {
                setState(() {
                  _isNavRailExtended = value;
                });
              },
            ),

          // Main content
          Expanded(
            child: Container(
              color: lsuPurple,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                    image: AssetImage('assets/roboticshint.jpg'),
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
                        const Text(
                          'In this room lies a giant robot that is so out of this world,\n'
                          'you could almost say it\'s _____',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter your answer',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white10,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: _checkAnswer,
                          child: const Text(
                            'Check Answer',
                            style: TextStyle(
                              color: lsuGold,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (_feedback.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _feedback,
                              style: TextStyle(
                                color: _feedback.contains('Correct') ? Colors.green : Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
                                "c"
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//bababooey