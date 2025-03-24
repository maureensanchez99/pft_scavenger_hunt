import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle Hunt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PuzzleScreen(),
    );
  }
}

class PuzzleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Hunt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Find the Hidden Location!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Image Placeholder',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Solve the puzzle by figuring out where the image was taken. Once you find the location, look for a hidden label with the answer.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzlePage()),
                );
              },
              child: Text('Start the Hunt'),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzlePage extends StatefulWidget {
  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final TextEditingController _controller = TextEditingController();
  String hint = "Hint: Look closely at the image";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter the Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Image Placeholder',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the Number',
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  hint = "New Hint: The number is near the bottom left";
                });
              },
              child: Text('Display Hint'),
            ),
            Text(hint, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to check the number and navigate to the next puzzle page can be added here
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
