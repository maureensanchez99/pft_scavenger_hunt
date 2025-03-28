import 'package:flutter/material.dart';
import '../pages/06_scavenger/capstone_stairs.dart';
import '../pages/07_scavenger/bengalbots_lab.dart';
import '../pages/04_scavenger/binary_clue.dart';
import '../pages/01_scavenger/riddle_passage.dart';
import '../pages/03_scavenger/soduku_puzzle.dart';
import '../pages/09_scavenger/chevron_center.dart';
import '../pages/05_scavenger/duck_page.dart';
import '../pages/12_scavenger/jp_fav_spot.dart';
import '../pages/08_scavenger/panera_page.dart';
import '../pages/11_scavenger/pft_page.dart';
import '../pages/10_scavenger/robot_thirdfloor.dart';
import '../pages/02_scavenger/puzzle_hurt.dart';
import '../pages/dashboard.dart';

class ScavengerHuntNavRail extends StatefulWidget {
  final int selectedIndex;
  final bool isExtended;
  final Function(bool)? onExtendedChange;
  
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);

  const ScavengerHuntNavRail({
    super.key,
    required this.selectedIndex,
    this.isExtended = false,
    this.onExtendedChange,
  });

  @override
  State<ScavengerHuntNavRail> createState() => _ScavengerHuntNavRailState();
}

class _ScavengerHuntNavRailState extends State<ScavengerHuntNavRail> {
  @override
  Widget build(BuildContext context) {
    // We don't need the effectiveIndex variable anymore with the new design
    
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: ScavengerHuntNavRail.lsuPurple.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with close button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    if (widget.onExtendedChange != null) {
                      widget.onExtendedChange!(false);
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          
          // Dashboard option
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
          
          const Divider(color: Colors.white24, height: 1),
          
          // Scrollable list of destinations
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDestinationTile(0, 'Riddle Passage', Icons.question_mark, const RiddlePassage()),
                _buildDestinationTile(1, 'Puzzle Hunt', Icons.search, PuzzleScreen()),
                _buildDestinationTile(2, 'Sudoku Puzzle', Icons.grid_3x3, const SodukuPuzzle()),
                _buildDestinationTile(3, 'Binary Clue', Icons.code, const BinaryClue()),
                _buildDestinationTile(4, 'The Duck', Icons.pets, const DuckPage()),
                _buildDestinationTile(5, 'Capstone Stairs', Icons.stairs, const CapstoneStairs()),
                _buildDestinationTile(6, 'Bengal Bots', Icons.science, const BengalbotsLab()),
                _buildDestinationTile(7, 'Panera', Icons.restaurant, const PaneraPage()),
                _buildDestinationTile(8, 'Chevron Center', Icons.business, const ChevronCenter()),
                _buildDestinationTile(9, 'Robot on 3rd Floor', Icons.smart_toy, const RobotThirdFloor()),
                _buildDestinationTile(10, 'PFT', Icons.school, const PftPage()),
                _buildDestinationTile(11, 'JP\'s Favorite Spot', Icons.favorite, const JpFavSpot()),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDestinationTile(int index, String label, IconData icon, Widget destination) {
    final bool isSelected = widget.selectedIndex == index;
    final bool isUnlocked = index == 0 || ChallengeProgress.isCompleted(index - 1);
    
    return ListTile(
      leading: Icon(
        icon, 
        color: isSelected ? ScavengerHuntNavRail.lsuGold : Colors.white70,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? ScavengerHuntNavRail.lsuGold : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? Colors.white.withOpacity(0.1) : null,
      trailing: isUnlocked ? null : const Icon(Icons.lock, color: Colors.white54, size: 16),
      onTap: () {
        if (index == widget.selectedIndex) return;
        
        if (!isUnlocked) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Complete the previous challenge first!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          );
          return;
        }
        
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => destination,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
