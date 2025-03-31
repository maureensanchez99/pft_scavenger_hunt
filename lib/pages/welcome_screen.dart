import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as math;
import '01_scavenger/riddle_passage.dart';
import '03_scavenger/soduku_puzzle.dart';
import '../pages/11_scavenger/pft_page.dart';
import 'dashboard.dart';
import 'tutorial_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023); // LSU Gold

  late AnimationController _animationController;
  late ConfettiController _confettiController;
  bool _isZooming = false;
  double _zoomScale = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  // Start zoom animation and navigate to tutorial page
  void _startZoomAndNavigate(BuildContext context) {
    // Play confetti animation
    _confettiController.play();
    
    setState(() {
      _isZooming = true;
    });

    // Animate the zoom effect
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _zoomScale = 8.0; // zzzoooooom speeeedd
      });
    });

    // Navigate after zoom animation completes
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const TutorialPage(),
              //const PftPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF1EEDB),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome text above the logo
                  if (!_isZooming) ...[
                    const Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 0),
                  ],
                  // Tiger image zoom animation CHATGPT cooked this one chat
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    transform: Matrix4.identity()..scale(_zoomScale),
                    transformAlignment: Alignment.center,
                    child: Image.asset(
                      'assets/lsu_logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  if (!_isZooming) ...[
                    const Text(
                      'The PFT Scavenger Hunt',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        _startZoomAndNavigate(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 11,
                        ),
                        backgroundColor: lsuGold,
                        foregroundColor: Colors.black,
                        elevation: 0, 
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Confetti overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: math.pi / 2, // Straight up
              emissionFrequency: 0.05,
              numberOfParticles: 30,
              maxBlastForce: 30,
              minBlastForce: 15,
              gravity: 0.1,
              particleDrag: 0.05, // Slower falling
              blastDirectionality: BlastDirectionality.explosive, // Spread in all directions
              colors: const [
                lsuPurple,
                lsuGold,
                Colors.white,
              ],
            ),
          ),
          // Left side confetti
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: math.pi / 1.5, // Angled up-right
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 25,
              minBlastForce: 10,
              gravity: 0.1,
              particleDrag: 0.05,
              colors: const [
                lsuPurple,
                lsuGold,
                Colors.white,
              ],
            ),
          ),
          // Right side confetti
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: math.pi / 2.5, // Angled up-left
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 25,
              minBlastForce: 10,
              gravity: 0.1,
              particleDrag: 0.05,
              colors: const [
                lsuPurple,
                lsuGold,
                Colors.white,
              ],
            ),
          ),
          // Bottom center confetti
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -math.pi / 2, // Straight down
              emissionFrequency: 0.05,
              numberOfParticles: 30,
              maxBlastForce: 30,
              minBlastForce: 15,
              gravity: 0.1,
              particleDrag: 0.05, // Slower falling
              blastDirectionality: BlastDirectionality.explosive, // Spread in all directions
              colors: const [
                lsuPurple,
                lsuGold,
                Colors.white,
              ],
            ),
          ),
          // Bottom left confetti
          Align(
            alignment: Alignment.bottomLeft,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -math.pi / 1.5, // Angled down-right
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 25,
              minBlastForce: 10,
              gravity: 0.1,
              particleDrag: 0.05,
              colors: const [
                lsuPurple,
                lsuGold,
                Colors.white,
              ],
            ),
          ),
          // Bottom right confetti
          Align(
            alignment: Alignment.bottomRight,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -math.pi / 2.5, // Angled down-left
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 25,
              minBlastForce: 10,
              gravity: 0.1,
              particleDrag: 0.05,
              colors: const [
                lsuPurple,
                lsuGold,
                Colors.white,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
