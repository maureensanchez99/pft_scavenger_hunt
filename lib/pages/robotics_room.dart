import 'package:flutter/material.dart';


void main() {
  runApp(const RoboticsRoom());
}

class RoboticsRoom extends StatelessWidget {
  const RoboticsRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robotics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF461D7C)),
        useMaterial3: true,
      )
    );
  }
}