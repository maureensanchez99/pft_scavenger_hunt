import 'package:flutter/material.dart';
import 'pages/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PFT Scavenger Hunt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF461D7C)),
        useMaterial3: true,
        fontFamily: 'ProximaNova',
      ),
      home: const WelcomeScreen(),
    );
  }
}

//According to all known laws of aviation, there's no way a bee should be able to fly