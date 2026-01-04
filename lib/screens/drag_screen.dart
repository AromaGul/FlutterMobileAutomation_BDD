import 'package:flutter/material.dart';

class DragScreen extends StatefulWidget {
  const DragScreen({super.key});

  @override
  State<DragScreen> createState() => _DragScreenState();
}

class _DragScreenState extends State<DragScreen> {
  List<PuzzlePiece> pieces = [];
  List<int?> slots = [null, null, null, null]; // Track which piece is in each slot
  bool isComplete = false;

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  void _initializePuzzle() {
    // Create 4 puzzle pieces that need to be arranged
    pieces = [
      PuzzlePiece(id: 1, label: '1', targetPosition: 0),
      PuzzlePiece(id: 2, label: '2', targetPosition: 1),
      PuzzlePiece(id: 3, label: '3', targetPosition: 2),
      PuzzlePiece(id: 4, label: '4', targetPosition: 3),
    ];
  }

  void _checkCompletion() {
    bool complete = true;
    for (int i = 0; i < slots.length; i++) {
      if (slots[i] != i + 1) { // Slot i should have piece i+1
        complete = false;
        break;
      }
    }
    if (complete && !isComplete) {
      setState(() {
        isComplete = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Puzzle Complete!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Complete the Picture',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // Target slots
            Text('Target Area:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return DragTarget<PuzzlePiece>(
                    key: ValueKey('target_$index'),
                    onAccept: (piece) {
                      setState(() {
                        slots[index] = piece.id;
                        _checkCompletion();
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      final pieceId = slots[index];
                      final piece = pieceId != null 
                          ? pieces.firstWhere((p) => p.id == pieceId)
                          : null;
                      return Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: piece == null ? Colors.grey[300] : Colors.green[200],
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: piece == null
                            ? Center(child: Text('${index + 1}', style: TextStyle(fontSize: 20)))
                            : Center(
                                child: Text(
                                  piece.label,
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                      );
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 50),
            // Draggable pieces
            Text('Pieces to Drag:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: pieces.where((piece) => !slots.contains(piece.id)).map((piece) {
                return Draggable<PuzzlePiece>(
                  key: ValueKey('piece_${piece.id}'),
                  data: piece,
                  feedback: Material(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          piece.label,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[300],
                  ),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        piece.label,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (isComplete)
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Puzzle Complete!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  key: ValueKey('puzzle_complete'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PuzzlePiece {
  final int id;
  final String label;
  final int targetPosition;

  PuzzlePiece({
    required this.id,
    required this.label,
    required this.targetPosition,
  });
}

