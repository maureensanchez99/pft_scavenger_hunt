import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

// Foolish Code

class SodukuPuzzle extends StatefulWidget {
  const SodukuPuzzle({super.key});

  @override
  State<SodukuPuzzle> createState() => _SodukuPuzzleState();
}



class _SodukuPuzzleState extends State<SodukuPuzzle> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  // State for nav rail
  bool _isNavRailExtended = false;
  bool questionDone = false;
  final String correctAnswer = "12345";
  String answerMessage = "";
  final inputAnswer = TextEditingController();
  bool hint1Press = false;
  bool hint2Press = false;


  void pressHint1()
  {
    setState(() 
    {
      hint1Press = true;  
    });
  }

  void pressHint2()
  {
    setState(() 
    {
      hint2Press = true;  
    });
  }

  void checkAnswer()
  {
    setState(() 
    {
      if(inputAnswer.text == correctAnswer)
      {
        questionDone = true;
        answerMessage = "You got it right! Good Job";
      }
      else
      {
        questionDone = false;
        answerMessage = "You did not get the right answer, Try Again!";
      }
    });
    showBotttomCard();
  }

  void showBotttomCard()
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



  // final answer = List<TextEditingController>.generate(5, (_) => TextEditingController());
  // final String answer1 = "1";
  // final String answer2 = "2";
  // final String answer3 = "3";
  // final String answer4 = "4";
  // final String answer5 = "5";

  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Stack
      (
        children: 
        [
          // Main content
          Container
          (
            decoration: const BoxDecoration
            (
              color: Color(0xFFF1EEDB)
            ),
            child: Column
            (
              children: 
              [
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
                Align
                (
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
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: 
                        [
                          Text
                          (
                            "Oh, it's times to go to the PFT Study Rooms. Be on the look out for a famaliar pattern."  ,
                            textAlign: TextAlign.center,
                            style: TextStyle
                            (
                              fontSize: 20,
                              color: lsuPurple
                            ),
                          ),
                          SizedBox(height:20),
                          Image.asset
                          (
                            "assets/sudoku.png",
                            height: 300,
                            fit: BoxFit.cover
                            
                          ),
                          SizedBox(height:20),
                          if(!hint1Press)
                            Column(
                              children: 
                              [
                                ElevatedButton
                                (
                                  onPressed: pressHint1, 
                                  style: ElevatedButton.styleFrom
                                  (
                                    backgroundColor: lsuPurple
                                  ),
                                  child: Text
                                  (
                                    "Need a hint?",
                                    style: TextStyle
                                    (
                                      color: Colors.white
                                    )
                                  ),
                                ),
                                SizedBox(height:20)
                              ],
                            )
                          else
                            Column
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 
                              [
                                if(!hint2Press)
                                  Column
                                  (
                                    children: 
                                    [
                                      Text
                                      (
                                        textAlign: TextAlign.center,
                                        "The grid kinda looks like Sudoku, doesn't it?",
                                        style: TextStyle
                                        (
                                          fontSize: 16,
                                          color: lsuPurple
                                        )
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton
                                      (
                                        onPressed: pressHint2,
                                        style: ElevatedButton.styleFrom
                                        (
                                          backgroundColor: lsuPurple
                                        ),
                                        child: Text
                                        (
                                          "Need another Hint?",
                                          style: TextStyle
                                          (
                                            color: Colors.white
                                          )
                                        )
                                      ),
                                      SizedBox(height:20)
                                    ],
                                  )
                                else
                                  Column
                                  (
                                    children: 
                                    [
                                      Text
                                      (
                                        textAlign: TextAlign.center,
                                        "The grid kinda looks like Sudoku, doesn't it?",
                                        style: TextStyle
                                        (
                                          fontSize: 16,
                                          color: lsuPurple
                                        )
                                      ),
                                      SizedBox(height:10),
                                      Text
                                      (
                                        textAlign: TextAlign.center,
                                        "Maybe the numbers above are an order of some sort?",
                                        style: TextStyle
                                        (
                                          fontSize: 16,
                                          color: lsuPurple
                                        )
                                      ),
                                      SizedBox(height: 20)
                                    ],
                                  )
                              ],
                            ),
                          if (!questionDone)
                              SizedBox(
                                width: 200,
                                child: TextField
                                (
                                  textAlign: TextAlign.center,
                                  style: TextStyle
                                  (
                                    fontSize: 20
                                  ),
                                  controller: inputAnswer,
                                  decoration: InputDecoration
                                  (
                                    border: OutlineInputBorder
                                      (
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    filled: true,
                                    fillColor: Color(0xFFA39AAC),
                                    hintText: "Code?",
                                    hintStyle: TextStyle
                                      (
                                        color: lsuPurple,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                      ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                            if(!questionDone)
                              ElevatedButton
                              (
                                onPressed: checkAnswer, 
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
                           //c
                          // Row
                          // (
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: 
                          //   [
                          //     // SizedBox
                          //     // (
                          //     //   child: ListWheelScrollView
                          //     //   (
                          //     //     itemExtent: 50, 
                          //     //     children:
                          //     //     [
                          //     //       Container
                          //     //       (
                          //     //         color: Colors.blue,
                          //     //         child: Text("data")
                          //     //       ),
                          //     //       Container
                          //     //       (
                          //     //         color: Colors.blue,
                          //     //         child: Text("data")
                          //     //       ),
                          //     //       Container
                          //     //       (
                          //     //         color: Colors.blue,
                          //     //         child: Text("data")
                          //     //       ),
                          //     //       Container
                          //     //       (
                          //     //         color: Colors.blue,
                          //     //         child: Text("data")
                          //     //       ),
                          //     //      ]
                          //     //     )
                          //     // )
                          //     // TextField
                          //     // (
                          //     //   textAlign: TextAlign.center,
                          //     //   controller: answer[0],
                          //     //   decoration:InputDecoration
                          //     //   (
                          //     //     hintText: "1"
                          //     //   )
                          //     // ),
                          //     // TextField
                          //     // (
                          //     //   controller: answer[1],
                          //     //   decoration:InputDecoration
                          //     //   (
                          //     //     hintText: "2"
                          //     //   )
                          //     // ),
                          //     // TextField
                          //     // (
                          //     //   controller: answer[2],
                          //     //   decoration:InputDecoration
                          //     //   (
                          //     //     hintText: "3"
                          //     //   )
                          //     // ),
                          //     // TextField
                          //     // (
                          //     //   controller: answer[3],
                          //     //   decoration:InputDecoration
                          //     //   (
                          //     //     hintText: "4"
                          //     //   )
                          //     // ),
                          //     // TextField
                          //     // (
                          //     //   controller: answer[4],
                          //     //   decoration:InputDecoration
                          //     //   (
                          //     //     hintText: "5"
                          //     //   )
                          //     // ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                )
                    
                  
                
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
                selectedIndex: 2, // Sudoku Puzzle is index 2
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