import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  String _swipeDirection = 'None';
  int _swipeCount = 0;
  double _dragStartX = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Swipe Left or Right',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            GestureDetector(
              key: ValueKey('swipe_container'),
              onHorizontalDragStart: (details) {
                _dragStartX = details.globalPosition.dx;
              },
              onHorizontalDragUpdate: (details) {
                // Track drag during update
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  final dragDistance = details.globalPosition.dx - _dragStartX;
                  
                  // Use velocity if available, otherwise use distance
                  if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 100) {
                    if (details.primaryVelocity! > 0) {
                      _swipeDirection = 'Right';
                    } else {
                      _swipeDirection = 'Left';
                    }
                  } else if (dragDistance.abs() > 50) {
                    if (dragDistance > 0) {
                      _swipeDirection = 'Right';
                    } else {
                      _swipeDirection = 'Left';
                    }
                  }
                  _swipeCount++;
                });
              },
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swipe, size: 60, color: Colors.blue),
                      SizedBox(height: 20),
                      Text(
                        'Swipe Here',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Last Swipe: $_swipeDirection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              key: ValueKey('swipe_direction'),
            ),
            SizedBox(height: 20),
            Text(
              'Swipe Count: $_swipeCount',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

