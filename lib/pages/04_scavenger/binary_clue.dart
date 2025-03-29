import 'package:flutter/material.dart';
import '../../widgets/nav_rail.dart';

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
              color: lsuPurple,
            ),
          ),
          const SizedBox(height: 16),
          ...options.asMap().entries.map((entry) {
            return RadioListTile(
              title: Text(
                entry.value,
                style: const TextStyle(
                  fontFamily: 'ProximaNova',
                  color: lsuPurple,
                ),
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

class BinaryClue extends StatefulWidget {
  const BinaryClue({super.key});

  @override
  State<BinaryClue> createState() => _BinaryClueState();
}

class _BinaryClueState extends State<BinaryClue>
    with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023); // LSU Gold
  static const Color lsuCorporatePurple =
      Color(0xFF3C1053); // LSU Corporate Purple
  static const Color lsuLightPurple = Color(0xFFA39AAC); // LSU Corporate Purple

  // State for nav rail
  bool _isNavRailExtended = false;

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
    List<int> incorrectQuestions = [];

    if (_radioSelection1 != 2) incorrectQuestions.add(1);
    if (_radioSelection2 != 1) incorrectQuestions.add(2);
    if (_radioSelection3 != 3) incorrectQuestions.add(3);
    if (_radioSelection4 != 0) incorrectQuestions.add(4);

    setState(() {
      if (incorrectQuestions.isEmpty) {
        _showCompletionMessage = true;
      } else {
        _hasIncorrectAnswers = true;
        // Show alert dialog with incorrect questions
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              titleTextStyle: const TextStyle(
                fontSize: 20,
                color: lsuPurple,
                fontFamily: 'ProximaNova',
                fontWeight: FontWeight.bold,
              ),
              contentTextStyle: const TextStyle(
                fontSize: 16,
                color: lsuPurple,
                fontFamily: 'ProximaNova',
              ),
              title: const Text('Incorrect Answers'),
              content: Text(
                'The following questions are incorrect:\n' +
                    incorrectQuestions.map((q) => '- Question $q').join('\n'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: lsuPurple,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lsuPurple.withOpacity(0.95),
        foregroundColor: lsuGold,
        title: Image.asset(
          'assets/lsu_logo_gold.png',
          width: 150,
          height: 100,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          // Background image
          Opacity(
            opacity:
                0.3, // Add opacity (0.0 = fully transparent, 1.0 = fully opaque)
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('../../../assets/lsu_oak_cropped.png'),
                  fit: BoxFit.cover,
                  scale: .3, // Changed from 0.5 to 0.3 for even more zoom
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          Column(
            children: [
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
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Text(
                            'Binary Vacuum Tube Quiz',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProximaNova',
                              color: lsuPurple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Stack(
                          children: [
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
                                          constraints: const BoxConstraints(
                                              maxWidth: 500),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: const Text(
                                            'Congratulations! All answers are correct!',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ProximaNova',
                                              color: lsuPurple,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 16.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: SegmentedButton<int>(
                                        showSelectedIcon: false,
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          side: MaterialStateProperty.all(
                                              BorderSide.none),
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
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
                                                'Q1',
                                                style: TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    color: lsuPurple),
                                              )),
                                          ButtonSegment<int>(
                                              value: 1,
                                              label: Text(
                                                'Q2',
                                                style: TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    color: lsuPurple),
                                              )),
                                          ButtonSegment<int>(
                                              value: 2,
                                              label: Text(
                                                'Q3',
                                                style: TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    color: lsuPurple),
                                              )),
                                          ButtonSegment<int>(
                                              value: 3,
                                              label: Text(
                                                'Q4',
                                                style: TextStyle(
                                                    fontFamily: 'ProximaNova',
                                                    color: lsuPurple),
                                              )),
                                        ],
                                        selected: _segmentSelection,
                                        onSelectionChanged:
                                            (Set<int> newSelection) {
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

                        // Add your content here
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Slide-in navigation rail when extended
          if (_isNavRailExtended)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ScavengerHuntNavRail(
                selectedIndex: 7, // Panera is index 7
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

  Widget getRadioSelectionBox() {
    switch (_segmentSelection.first) {
      case 0:
        return RadioSelectionBox(
          title: 'Which numbers can a vacuum tube represent?',
          options: const [
            '1, 2',
            '0, 1, 2',
            '0, 1',
            '1, 2, 3'
          ],
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
          title: 'What are binary vacuum tubes used for today?',
          options: const ['Computers', 'High-End Audio Hardware', 'Luxury Electric Cars', 'UPS Trucks'],
          radioSelection: _radioSelection2,
          correctAnswer: 1,
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
          title: 'Where can you find binary vacuum tubes on display in PFT?',
          options: const [
            'Panera',
            'Petroleum Engineering Labs Hall',
            'Robotics Lab',
            'Chemical Engineering Labs Hall'
          ],
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
          title: 'Which device is known for using binary numbers in the past?',
          options: const ['Computers', 'Engines', 'Printing Press', 'Guns'],
          radioSelection: _radioSelection4,
          correctAnswer: 0,
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
