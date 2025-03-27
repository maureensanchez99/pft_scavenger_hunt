import 'package:flutter/material.dart';
import '../widgets/nav_rail.dart';

class RiddlePassage extends StatefulWidget {
  const RiddlePassage({super.key});

  @override
  State<RiddlePassage> createState() => _RiddlePassageState();
}

class _RiddlePassageState extends State<RiddlePassage> with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lsuGold,
        foregroundColor: lsuPurple,
        title: const Text(
          'Riddle Passage',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          const ScavengerHuntNavRail(selectedIndex: 4),
          Expanded(
            child: AnimatedBuilder(
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
                  child: child,
                );
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Riddle Passage Content',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Add your content here
                    ],
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