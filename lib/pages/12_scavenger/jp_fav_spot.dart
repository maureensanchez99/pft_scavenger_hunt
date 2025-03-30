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
  

  void showFinalQuestion()
  {
    setState(() 
    {
      finalQuestionReady = true;  
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