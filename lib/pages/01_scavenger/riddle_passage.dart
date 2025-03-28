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
  final _answer = TextEditingController();
  final String correctAnswer = "1344";
  String answerMessage = "";
  bool questionDone = false;


  void _checkAnswer()
  {
    setState(() 
    {
      if(_answer.text == correctAnswer)
      {
        questionDone = true;
        answerMessage = "You got it right! Good Job";
      }
      else
      {
        questionDone = false;
        answerMessage = "You did not get the right answer, you fucking dumbass";
      }
    });
    _showBottomCard();
  }

  void _showBottomCard()
  {
    showModalBottomSheet
    (
      context: context,
      builder: (BuildContext context)
      {
        return Container
        (
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration
          (
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            gradient: LinearGradient
            (
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: 
              [
                Color(0xFFFDD023), // lsuGold
                Color(0xFF461D7C), // lsuPurple
              ],
            ),
          ),
          child: Center
          (
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Text
                (
                  answerMessage,
                  style: TextStyle
                  (
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
                
              ]
            )
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            decoration: const BoxDecoration
            (
              color:Colors.white
            ),
            child: Column
            (
              children: 
              [
                // Hamburger menu at the top left
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding
                  (
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: IconButton
                    (
                      icon: const Icon(Icons.menu, color: lsuPurple),
                      onPressed: () 
                      {
                        setState(() 
                        {
                          _isNavRailExtended = !_isNavRailExtended;
                        });
                      },
                    ),
                  ),
                ),
                
                // Main content
                Expanded
                (
                  child: SingleChildScrollView
                  (
                    child: Center
                    (
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              "As we begin the hunt, you need to find where Jp went",
                              textAlign: TextAlign.center,
                              style: TextStyle
                              (
                                fontSize: 24,
                                fontWeight: FontWeight.bold, 
                                
                                color: lsuPurple
                              ),
                            ),
                            Image.asset("assets/Jpnote.PNG"),
                            SizedBox(height:20),
                            if (!questionDone)
                              TextField
                              (
                                textAlign: TextAlign.center,
                                style: TextStyle
                                (
                                  fontSize: 20
                                ),
                                controller: _answer,
                                decoration: InputDecoration
                                (
                                  border: OutlineInputBorder
                                    (
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  filled: true,
                                  fillColor: Color(0xFFA39AAC),
                                  hintText: "What is the room Jp is always in?",
                                  hintStyle: TextStyle
                                    (
                                      color: lsuPurple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    ),
                                ),
                              ),
                              SizedBox(height: 18),
                            if(!questionDone)
                              ElevatedButton
                              (
                                onPressed: _checkAnswer, 
                                style: ElevatedButton.styleFrom
                                (
                                  backgroundColor: lsuGold
                                ),
                                child: 
                                  Text
                                  (
                                    "Check",
                                    style: TextStyle
                                    (
                                      fontSize: 15,
                                      color: lsuPurple
                                    ),
                                  )
                                    
                                  
                              )
                              
                            else
                              SizedBox
                              (
                                height: 50,
                                width: 100,
                                child:
                                (
                                  DecoratedBox
                                  (
                                    decoration: BoxDecoration
                                    (
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.green,
                                    ),
                                    child:
                                    (
                                      Icon
                                      (
                                        Icons.check,
                                        color: Colors.white
                                      )
                                    )
                                  )
                                )
                              )
                          ], //children
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