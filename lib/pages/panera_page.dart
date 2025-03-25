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

  Set<int> _segmentSelection = {0};
  int _radioSelection = 0;

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity:
                0.4, // Add opacity (0.0 = fully transparent, 1.0 = fully opaque)
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/lsu_oak_cropped.png'),
                  fit: BoxFit.cover,
                  scale: .3, // Changed from 0.5 to 0.3 for even more zoom
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          // Center container with content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(24.0),
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Select your answer:',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ProximaNova',
                        ),
                      ),
                      const SizedBox(height: 16),
                      RadioListTile(
                        title: const Text(
                          'Option 1',
                          style: TextStyle(fontFamily: 'ProximaNova'),
                        ),
                        value: 0,
                        groupValue: _radioSelection,
                        onChanged: (value) {
                          setState(() {
                            _radioSelection = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text(
                          'Option 2',
                          style: TextStyle(fontFamily: 'ProximaNova'),
                        ),
                        value: 1,
                        groupValue: _radioSelection,
                        onChanged: (value) {
                          setState(() {
                            _radioSelection = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text(
                          'Option 3',
                          style: TextStyle(fontFamily: 'ProximaNova'),
                        ),
                        value: 2,
                        groupValue: _radioSelection,
                        onChanged: (value) {
                          setState(() {
                            _radioSelection = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text(
                          'Option 4',
                          style: TextStyle(fontFamily: 'ProximaNova'),
                        ),
                        value: 3,
                        groupValue: _radioSelection,
                        onChanged: (value) {
                          setState(() {
                            _radioSelection = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16.0),
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SegmentedButton<int>(
                    showSelectedIcon: false,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      side: MaterialStateProperty.all(BorderSide.none),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return lsuPurple.withOpacity(
                                0.2); // Transparent purple for selected state
                          }
                          return Colors
                              .transparent; // Transparent for unselected state
                        },
                      ),
                    ),
                    segments: const [
                      ButtonSegment<int>(
                          value: 0,
                          label: Text(
                            'Choice 1',
                            style: TextStyle(fontFamily: 'ProximaNova'),
                          )),
                      ButtonSegment<int>(
                          value: 1,
                          label: Text(
                            'Choice 2',
                            style: TextStyle(fontFamily: 'ProximaNova'),
                          )),
                      ButtonSegment<int>(
                          value: 2,
                          label: Text(
                            'Choice 3',
                            style: TextStyle(fontFamily: 'ProximaNova'),
                          )),
                      ButtonSegment<int>(
                          value: 3,
                          label: Text(
                            'Choice 4',
                            style: TextStyle(fontFamily: 'ProximaNova'),
                          )),
                    ],
                    selected: _segmentSelection,
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        _segmentSelection = newSelection;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
