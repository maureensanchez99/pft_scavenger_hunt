import 'package:flutter/material.dart';
import '../../pages/welcome_screen.dart';

class finalPage extends StatefulWidget
{
  const finalPage({super.key});

    @override
    State<finalPage> createState() => _finalPage();
}

class _finalPage extends State<finalPage>
{
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023); 

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Stack
      (
        children: 
        [
          Container(
            decoration: BoxDecoration
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
                Expanded(
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: 
                    [
                      Text
                  (
                    textAlign: TextAlign.center,
                    "Thank You for Playing Our Foolish Game! =)",
                    style:TextStyle
                    (
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: lsuPurple
                    )
                  ),
                  ElevatedButton
                  (
                    style: ElevatedButton.styleFrom
                    (
                      backgroundColor: lsuGold
                    ),
                    onPressed: () => Navigator.push
                                    (
                                      context,
                                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                    ) ,
                     child: Text
                     (
                      textAlign: TextAlign.center,
                      "Return to Welcome",
                      style: TextStyle
                      (
                        color: lsuPurple
                      ),
                    )
                  )
                    ],
                  ),
                )
                  
              ],   
            ),
          )
        ]
      ),
    );
  }
}