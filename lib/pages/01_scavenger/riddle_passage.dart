import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

class RiddlePassage extends StatefulWidget {
  const RiddlePassage({super.key});

  @override
  State<RiddlePassage> createState() => _RiddlePassageState();
}

class _RiddlePassageState extends State<RiddlePassage> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  // State for nav rail
  bool _isNavRailExtended = false;
  final answer = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lsuPurple,
        title: const Text(
          'Riddle Passage',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFDD023),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main content
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFDD023), // lsuGold
                  Color(0xFF461D7C), // lsuPurple
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
                  child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "As we begin the hunt, you need to find where Jp went",
                            textAlign: TextAlign.center,
                            style: TextStyle
                            (
                              fontSize: 24,
                              fontWeight: FontWeight.bold, 
                              
                              color: Colors.white
                            ),
                          ),
                          Image.asset("assets/Jpnote.PNG"),
                          TextField
                          (
                            controller: answer,
                            decoration: InputDecoration
                            (
                              border: OutlineInputBorder
                                (
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              fillColor: Colors.white,
                              hintText: "What is the room Jp is always in?",
                              hintStyle: TextStyle
                                (
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                ),
                              
                            ),
                            

                          )

                        ],
                      ),
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
                selectedIndex: 0, // Riddle Passage is index 0
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