import 'package:flutter/material.dart';
import '../pages/welcome_screen.dart';
import '../pages/capstone_stairs.dart';
import '../pages/bengalbots_lab.dart';
import '../pages/binary_clue.dart';
import '../pages/riddle_passage.dart';
import '../pages/soduku_puzzle.dart';
import '../pages/third_floor.dart';
import '../pages/chevron_center.dart';
import '../pages/duck_page.dart';
import '../pages/jp_fav_spot.dart';
import '../pages/panera_page.dart';
import '../pages/pft_page.dart';
import '../pages/robotics_room.dart';

class ScavengerHuntNavRail extends StatelessWidget {
  final int selectedIndex;
  
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);

  const ScavengerHuntNavRail({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      backgroundColor: lsuPurple.withOpacity(0.9),
      unselectedIconTheme: const IconThemeData(color: Colors.white70),
      unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
      selectedIconTheme: IconThemeData(color: lsuGold),
      selectedLabelTextStyle: TextStyle(color: lsuGold, fontWeight: FontWeight.bold),
      onDestinationSelected: (int index) {
        if (index == selectedIndex) return;
        
        // Navigate to the selected page
        Widget destinationPage;
        switch (index) {
          case 0:
            destinationPage = const WelcomeScreen();
            break;
          case 1:
            destinationPage = const CapstoneStairs();
            break;
          case 2:
            destinationPage = const BengalbotsLab();
            break;
          case 3:
            destinationPage = const BinaryClue();
            break;
          case 4:
            destinationPage = const RiddlePassage();
            break;
          case 5:
            destinationPage = const SodukuPuzzle();
            break;
          case 6:
            destinationPage = const ThirdFloor();
            break;
          case 7:
            destinationPage = const ChevronCenter();
            break;
          case 8:
            destinationPage = const DuckPage();
            break;
          case 9:
            destinationPage = const JpFavSpot();
            break;
          case 10:
            destinationPage = const PaneraPage();
            break;
          case 11:
            destinationPage = const PftPage();
            break;
          case 12:
            destinationPage = const RoboticsRoom();
            break;
          default:
            destinationPage = const WelcomeScreen();
        }
        
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      labelType: NavigationRailLabelType.selected,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Welcome'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.stairs),
          label: Text('Capstone'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.science),
          label: Text('Bengalbots'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.code),
          label: Text('Binary'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.question_mark),
          label: Text('Riddle'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.grid_3x3),
          label: Text('Sudoku'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.apartment),
          label: Text('3rd Floor'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.business),
          label: Text('Chevron'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.pets),
          label: Text('Duck'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.favorite),
          label: Text('JP Spot'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.restaurant),
          label: Text('Panera'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.school),
          label: Text('PFT'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.smart_toy),
          label: Text('Robot'),
        ),
      ],
    );
  }
}
