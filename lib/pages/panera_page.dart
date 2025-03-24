import 'package:flutter/material.dart';
import 'capstone_stairs.dart';

class PaneraQuiz extends StatefulWidget {
  const PaneraQuiz({super.key});

  @override
  State<PaneraQuiz> createState() => _PaneraQuizState();
}

class _PaneraQuizState extends State<PaneraQuiz>
    with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023); // LSU Gold
  static const Color lsuCorporatePurple =
      Color(0xFF3C1053); // LSU Corporate Purple
  static const Color lsuLightPurple = Color(0xFFA39AAC); // LSU Corporate Purple

  Set<int> _selection = {0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lsuPurple,
        title: Image.asset(
          'assets/lsu_logo_gold.png',
          width: 150,
          height: 100,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(
            child: Text(
              'Welcome to the PFT Scavenger Hunt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 35.0),
            child: SegmentedButton<int>(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              segments: const [
                ButtonSegment<int>(value: 0, label: Text('Choice 1')),
                ButtonSegment<int>(value: 1, label: Text('Choice 2')),
                ButtonSegment<int>(value: 2, label: Text('Choice 3')),
                ButtonSegment<int>(value: 3, label: Text('Choice 4')),
              ],
              selected: _selection,
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  _selection = newSelection;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
