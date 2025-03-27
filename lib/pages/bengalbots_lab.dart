import 'package:flutter/material.dart';
import '../widgets/nav_rail.dart';

class BengalbotsLab extends StatefulWidget{
    const BengalbotsLab({super.key});

  @override
  State<BengalbotsLab> createState() => _BengalbotsLabState();
}

class _BengalbotsLabState extends State<BengalbotsLab> with SingleTickerProviderStateMixin {
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
          'Bengalbots Lab',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          const ScavengerHuntNavRail(selectedIndex: 2),
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
                        'Bengalbots Lab Content',
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