import 'package:flutter/material.dart';
import 'capstone_stairs.dart';

class RadioSelectionBox extends StatelessWidget {
  final String title;
  final List<String> options;
  final int radioSelection;
  final int correctAnswer;
  final Function(int?) onRadioChanged;
  final VoidCallback? onNextPressed;
  final bool showNextButton;
  final bool showCheckButton;
  final bool hasIncorrectAnswers;
  final VoidCallback? onCheckPressed;
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple

  const RadioSelectionBox({
    super.key,
    this.title = 'Select your answer:',
    this.options = const ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    required this.radioSelection,
    required this.onRadioChanged,
    required this.correctAnswer,
    this.onNextPressed,
    this.showNextButton = false,
    this.showCheckButton = false,
    this.hasIncorrectAnswers = false,
    this.onCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ProximaNova',
            ),
          ),
          const SizedBox(height: 16),
          ...options.asMap().entries.map((entry) {
            return RadioListTile(
              title: Text(
                entry.value,
                style: const TextStyle(fontFamily: 'ProximaNova'),
              ),
              value: entry.key,
              groupValue: radioSelection,
              onChanged: onRadioChanged,
            );
          }).toList(),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity:
                  ((showNextButton || showCheckButton) && radioSelection != -1)
                      ? 1.0
                      : 0.0,
              child: SizedBox(
                height: ((showNextButton || showCheckButton) &&
                        radioSelection != -1)
                    ? null
                    : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showCheckButton) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          onPressed: onCheckPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                hasIncorrectAnswers ? Colors.red : lsuPurple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                          child: const Text(
                            'Check',
                            style: TextStyle(
                              fontFamily: 'ProximaNova',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (showNextButton) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          onPressed: onNextPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: lsuPurple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'ProximaNova',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

  // Initialize radio selections to -1 (no selection)
  int _radioSelection1 = -1;
  int _radioSelection2 = -1;
  int _radioSelection3 = -1;
  int _radioSelection4 = -1;
  Set<int> _segmentSelection = {0};

  // Add state variable to track if answers are incorrect
  bool _hasIncorrectAnswers = false;
  bool _showCompletionMessage = false;

  // Method to check all answers
  void checkAnswers() {
    bool allCorrect = _radioSelection1 == 2 && // First box correct answer
        _radioSelection2 == 0 && // Second box correct answer
        _radioSelection3 == 3 && // Third box correct answer
        _radioSelection4 == 1; // Fourth box correct answer

    setState(() {
      if (allCorrect) {
        _showCompletionMessage = true;
      } else {
        _hasIncorrectAnswers = true;
      }
    });
  }

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
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showCompletionMessage ? 1.0 : 0.0,
                child: _showCompletionMessage
                    ? Container(
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.all(24.0),
                        constraints: const BoxConstraints(maxWidth: 500),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          'Congratulations! All answers are correct!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNova',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (!_showCompletionMessage) ...[
                Center(
                  child: getRadioSelectionBox(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
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
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget getRadioSelectionBox() {
    switch (_segmentSelection.first) {
      case 0:
        return RadioSelectionBox(
          title: 'Question 1:',
          options: const ['First A', 'First B', 'First C', 'First D'],
          radioSelection: _radioSelection1,
          correctAnswer: 2,
          onRadioChanged: (value) {
            setState(() {
              _radioSelection1 = value!;
            });
          },
          showNextButton: true,
          onNextPressed: () {
            setState(() {
              _segmentSelection = {1};
            });
          },
        );
      case 1:
        return RadioSelectionBox(
          title: 'Question 2:',
          options: const ['Second A', 'Second B', 'Second C', 'Second D'],
          radioSelection: _radioSelection2,
          correctAnswer: 0,
          onRadioChanged: (value) {
            setState(() {
              _radioSelection2 = value!;
            });
          },
          showNextButton: true,
          onNextPressed: () {
            setState(() {
              _segmentSelection = {2};
            });
          },
        );
      case 2:
        return RadioSelectionBox(
          title: 'Question 3:',
          options: const ['Third A', 'Third B', 'Third C', 'Third D'],
          radioSelection: _radioSelection3,
          correctAnswer: 3,
          onRadioChanged: (value) {
            setState(() {
              _radioSelection3 = value!;
            });
          },
          showNextButton: true,
          onNextPressed: () {
            setState(() {
              _segmentSelection = {3};
            });
          },
        );
      case 3:
        return RadioSelectionBox(
          title: 'Question 4:',
          options: const ['Fourth A', 'Fourth B', 'Fourth C', 'Fourth D'],
          radioSelection: _radioSelection4,
          correctAnswer: 1,
          onRadioChanged: (value) {
            setState(() {
              _radioSelection4 = value!;
              _hasIncorrectAnswers =
                  false; // Reset error state when selection changes
            });
          },
          showCheckButton: true,
          hasIncorrectAnswers: _hasIncorrectAnswers,
          onCheckPressed: checkAnswers,
        );
      default:
        return RadioSelectionBox(
          radioSelection: _radioSelection1,
          correctAnswer: 2,
          onRadioChanged: (value) {
            setState(() {
              _radioSelection1 = value!;
            });
          },
        );
    }
  }
}
