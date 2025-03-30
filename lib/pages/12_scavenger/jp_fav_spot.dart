import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../../pages/13_scavenger/final.dart';
import '../dashboard.dart';
// Foolish Code

class JpFavSpot extends StatefulWidget {
  const JpFavSpot({super.key});

  @override
  State<JpFavSpot> createState() => _JpFavSpotState();
}

class _JpFavSpotState extends State<JpFavSpot> 
{
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  // State for nav rail
  bool _isNavRailExtended = false;
  bool finalQuestionReady = false;
  bool readNote = false;
  final inputAnswer = TextEditingController();
  String FinalAnswer = "foolishduck";
  
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

  void checkCorrect()
  {
    if(inputAnswer.text == FinalAnswer)
    {
      Navigator.push
      (
        context,
        MaterialPageRoute(builder: (context) => finalPage()),
      );

    }
  }


  void showJpFinalNote()
  {
    setState(() 
    {
      readNote = true;
    });
    showDialog
    (
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog
        (
          title: Text
          (
            textAlign: TextAlign.center,
            "Jp's Final Note to All",
          ),
          content: SingleChildScrollView
          (
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Text
                (
                  textAlign: TextAlign.center,
                  "Hey, Everyone! It's Jp.\n\n Thank you for playing our game. My team and I tried our best to make a good scavenger hunt for y'all.\n\n Now, this lead you to right here, on top of the Capstone Stair, sitting and looking forward to the open space. \n\n This is my favorite spot because at night when the building is silent, it is a nice place to collect your thoughts. I have sat there many times and many more time in my coming years. It is a part that I will miss when I graduate, so I wanted to share it with y'all.\n\n I have always been a fan of mystery and puzzle game. It inspires me to always be curious about everything around me and see every obstacles as a puzzle. After all, A problem is just a puzzle that we haven't arrange all of our pieces properly yet. I hope you can see it like I do as well. \n\n Now, the final puzzle will show up when you close this box. The answer is simple, remember what I said about arranging the pieces we have? You already have the pieces within this game, you just need to find them and order them properly. \n\n Hint: What is the point of a Navigation Rail if a scavenger hunt is linear? As in, why can you go back to the other puzzles?",
                ),
              ],
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
                Expanded
                (
                  child: SingleChildScrollView
                  (
                    child: Column
                      (
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

                                "Go to the top of the Capstone Stairs and have a seat",
                                style: TextStyle
                                (
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3C1053)
                                ),
                              ),
                              SizedBox(height: 20),
                              Image.asset("assets/capstoneStair.jpg", height: 100, width: 400, fit: BoxFit.cover),
                              SizedBox(height: 20),
                              ElevatedButton
                              (
                                onPressed: showJpFinalNote, 
                                style: ElevatedButton.styleFrom
                                (
                                  backgroundColor:  Color(0xFF3C1053)
                                ),
                                child: Text
                                (
                                  textAlign: TextAlign.center,
                                  "Read Me",
                                  style: TextStyle
                                  (
                                    color: lsuGold,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ),
                              SizedBox(height: 20),
                              if(readNote)
                              Column
                              (
                                children: 
                                [
                                  SizedBox
                                  (
                                    width: 200,
                                    child: TextField
                                    (
                                      textAlign: TextAlign.center,
                                      controller: inputAnswer,
                                      decoration: InputDecoration
                                      (
                                        border: OutlineInputBorder
                                        (
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        hintText: "Final Input Answer",
                                        hintStyle: TextStyle
                                        (
                                          color: lsuPurple
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFF1EEDB)
                                        
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:20),
                                  ElevatedButton
                                  (
                                    onPressed:  checkCorrect, 
                                    style: ElevatedButton.styleFrom
                                    (
                                      backgroundColor:  Color(0xFF3C1053)
                                    ),
                                    child: Text
                                    (
                                      textAlign: TextAlign.center,
                                      "Check",
                                      style: TextStyle
                                      (
                                        color: lsuGold,
                                        fontWeight: FontWeight.bold
                                      )
                                    )
                                  )

                                ],
                              )

                            ],
                          )
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
