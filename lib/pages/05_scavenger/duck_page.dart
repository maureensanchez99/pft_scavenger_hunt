import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';
import '../dashboard.dart';


// Foolish Code

class DuckPage extends StatefulWidget {
  const DuckPage({super.key});

  @override
  State<DuckPage> createState() => _DuckPageState();
}

class _DuckPageState extends State<DuckPage> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold


  
  // State for nav rail
  bool _isNavRailExtended = false;
  final List<String> answers = ["duck", "Duck", "Rubber Duck", "Rubber duck", "rubber duck", "rubber Duck", "Rubber Duckie", "rubber Duckie", "Rubber duckie", "rubber duckie", "duckie", "Duckie", "ducky", "Ducky", "Rubber ducky", "Rubber Ducky", "rubber ducky", "rubber Ducky"];
  final inputAnswer = TextEditingController();
  String answerMessage = "";
  bool questionDone = false;



 void checkAnswer()
  {
    setState(() 
    {
      bool isCorrect = false;
      for (int i = 0; i < answers.length; i++)
      {
        if(inputAnswer.text == answers[i])
        {
          isCorrect = true;
          questionDone = true;
          answerMessage = "You got it right! Good Job";
          // Mark Duck Page as completed (index 4)
          ChallengeProgress.markCompleted(4);
          break;
        }
      }
      
      if (!isCorrect) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            decoration: const BoxDecoration(
             color: lsuGold
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
                          children: 
                          [
                            Text
                            (
                              textAlign: TextAlign.center,
                              "Story Time:\n A while back, someone vandalise PFT with a specific animal\n One of said animal was put in The Commons\n Go find it....",
                              style: TextStyle
                              ( 
                                color: lsuPurple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            SizedBox(height: 20),
                            GestureDetector
                            (
                              child: Image.asset("assets/commons.PNG"),
                              onTap:() 
                              {
                              showDialog
                              (
                                context: context,
                                builder: (BuildContext context)
                                {
                                  return Dialog
                                  (
                                    insetPadding: EdgeInsets.zero,
                                    child: Stack
                                    (
                                      children: 
                                      [
                                        InteractiveViewer
                                        (
                                          boundaryMargin: const EdgeInsets.all(0),
                                          minScale: 1,
                                          maxScale: 4,
                                          panAxis: PanAxis.free,
                                          child: Image.asset("assets/commons.PNG", fit: BoxFit.contain)
                                        )
                                      ],
                                    ),
                                  );
                                }
                                );
                              },
                            ),
                            Text
                            (
                              textAlign: TextAlign.center,
                              "Click the image to zoom in",
                              style: TextStyle
                              (
                                color: lsuPurple,
                              )
                            ),
                            SizedBox(height: 20),
                          if (!questionDone)
                                Column(
                                  children: [
                                    TextField
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
                                        fillColor: Colors.white,
                                        hintText: "What is the animal?",
                                        hintStyle: TextStyle
                                          (
                                            color: Color(0xFF3C1053),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                          ),
                                      ),
                                    ),
                                    SizedBox(height:20),
                                    ElevatedButton
                                    (
                                      onPressed: checkAnswer, 
                                      style: ElevatedButton.styleFrom
                                      (
                                        backgroundColor: Color(0xFF3C1053)
                                      ),
                                      child: 
                                        Text
                                        (
                                          "Check",
                                          style: TextStyle
                                          (
                                            fontSize: 15,
                                            color: Color(0xFFF1EEDB)
                                          ),
                                        )
                                          
                                        
                                    )
                                  ],
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
                          ],
                        ),
                      )
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
                selectedIndex: 4, // The Duck is index 4
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