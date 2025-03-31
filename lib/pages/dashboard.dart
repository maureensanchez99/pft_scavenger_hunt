import 'package:flutter/material.dart';
import '../widgets/nav_rail.dart';
import '01_scavenger/riddle_passage.dart';
import '02_scavenger/puzzle_hurt.dart';
import '03_scavenger/soduku_puzzle.dart';
import '04_scavenger/binary_clue.dart';
import '05_scavenger/duck_page.dart';
import '06_scavenger/capstone_stairs.dart';
import '07_scavenger/bengalbots_lab.dart';
import '08_scavenger/panera_page.dart';
import '09_scavenger/chevron_center.dart';
import '10_scavenger/robotics_room.dart';
import '11_scavenger/pft_page.dart';
import '12_scavenger/jp_fav_spot.dart';
import 'tutorial_page.dart';

// Static class to manage challenge completion status
class ChallengeProgress {
  static final List<bool> _challengesCompleted = List.generate(12, (index) => false);
  
  static bool isCompleted(int index) {
    return _challengesCompleted[index];
  }
  
  static void markCompleted(int index) {
    if (index >= 0 && index < _challengesCompleted.length) {
      _challengesCompleted[index] = true;
    }
  }
  
  static List<bool> getAllStatus() {
    return List.from(_challengesCompleted);
  }

  static bool isUnlocked(int index) {
    if (index == 0) return true; // First challenge is always unlocked
    return isCompleted(index - 1); // Challenge is unlocked if previous one is completed
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  // Get completion status from shared state
  List<bool> get _challengesCompleted => ChallengeProgress.getAllStatus();
  
  // State for nav rail
  bool _isNavRailExtended = false;

  // Check if all challenges are completed
  bool get _allChallengesCompleted => _challengesCompleted.every((completed) => completed);

  @override
  Widget build(BuildContext context) {
    // Calculate progress percentage
    final double progressPercentage = _challengesCompleted.where((completed) => completed).length / _challengesCompleted.length;
    
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            color: lsuPurple,
            child: Column(
              children: [
                // Hamburger menu and arrow
                Stack(
                  children: [
                    // Hamburger menu at the top left
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 40.0),
                        child: IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _isNavRailExtended = !_isNavRailExtended;
                            });
                          },
                        ),
                      ),
                    ),
                    // Exit button at the top right
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 40.0),
                        child: IconButton(
                          icon: const Icon(Icons.exit_to_app, color: Colors.red, size: 24),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const TutorialPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                                transitionDuration: const Duration(milliseconds: 300),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Arrow and text
                    Positioned(
                      left: 67,
                      top: 53,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 17,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Access the Challenges Here',
                            style: TextStyle(
                              color: lsuGold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          'Complete each hunt and continue to the next challenge!',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _allChallengesCompleted 
                              ? 'Congratulations! You\'ve completed all the challenges!'
                              : 'Good luck!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: lsuGold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        
                        // Progress section
                        Text(
                          'Your Progress so Far',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: lsuGold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Progress bar
                        Container(
                          width: double.infinity,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              FractionallySizedBox(
                                widthFactor: progressPercentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: lsuGold,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(_challengesCompleted.where((completed) => completed).length)} of ${_challengesCompleted.length} challenges completed',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 48),
                        
                        // Challenge list
                        Expanded(
                          child: ListView.builder(
                            itemCount: _challengesCompleted.length,
                            itemBuilder: (context, index) {
                              String challengeName;
                              IconData challengeIcon;
                              bool isUnlocked = ChallengeProgress.isUnlocked(index);
                              bool isCompleted = _challengesCompleted[index];
                              
                              switch (index) {
                                case 0:
                                  challengeName = 'Riddle Passage';
                                  challengeIcon = Icons.question_mark;
                                  break;
                                case 1:
                                  challengeName = 'Puzzle Hunt';
                                  challengeIcon = Icons.search;
                                  break;
                                case 2:
                                  challengeName = 'Sudoku Puzzle';
                                  challengeIcon = Icons.grid_3x3;
                                  break;
                                case 3:
                                  challengeName = 'Binary Clue';
                                  challengeIcon = Icons.code;
                                  break;
                                case 4:
                                  challengeName = 'The Duck';
                                  challengeIcon = Icons.pets;
                                  break;
                                case 5:
                                  challengeName = 'Capstone Stairs';
                                  challengeIcon = Icons.stairs;
                                  break;
                                case 6:
                                  challengeName = 'Bengal Bots';
                                  challengeIcon = Icons.science;
                                  break;
                                case 7:
                                  challengeName = 'Panera';
                                  challengeIcon = Icons.restaurant;
                                  break;
                                case 8:
                                  challengeName = 'Chevron Center';
                                  challengeIcon = Icons.business;
                                  break;
                                case 9:
                                  challengeName = 'Robot on 3rd Floor';
                                  challengeIcon = Icons.smart_toy;
                                  break;
                                case 10:
                                  challengeName = 'PFT';
                                  challengeIcon = Icons.school;
                                  break;
                                case 11:
                                  challengeName = 'JP\'s Favorite Spot';
                                  challengeIcon = Icons.favorite;
                                  break;
                                default:
                                  challengeName = 'Unknown Challenge';
                                  challengeIcon = Icons.help_outline;
                              }
                              
                              return Card(
                                color: isCompleted 
                                    ? lsuGold.withOpacity(0.8) 
                                    : isUnlocked 
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.white.withOpacity(0.05),
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: Icon(
                                    challengeIcon,
                                    color: isCompleted ? lsuPurple : Colors.white,
                                    size: 28,
                                  ),
                                  title: Text(
                                    challengeName,
                                    style: TextStyle(
                                      color: isCompleted ? lsuPurple : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: isCompleted
                                    ? const Icon(Icons.check_circle, color: Color(0xFF461D7C), size: 28)
                                    : isUnlocked
                                        ? const Icon(Icons.circle_outlined, color: Colors.white54, size: 28)
                                        : const Icon(Icons.lock, color: Colors.white54, size: 28),
                                ),
                              );
                            },
                          ),
                        ),
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
                selectedIndex: -1, // Use -1 for Dashboard since it's not in the destinations list
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