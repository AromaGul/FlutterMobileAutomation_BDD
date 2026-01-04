import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

/// Page Object Model for Drag Screen
class DragPage {
  final WidgetTester tester;

  DragPage(this.tester);

  // Locators
  Finder get dragScreenTitle => find.text('Drag Screen');
  Finder get puzzleCompleteText => find.byKey(ValueKey('puzzle_complete'));

  // Actions
  Future<void> verifyDragScreen() async {
    expect(dragScreenTitle, findsOneWidget);
  }

  Future<void> dragPieceToSlot(int pieceNumber, int targetSlot) async {
    // Find the draggable piece (pieceNumber is 1-4)
    final pieceFinder = find.byKey(ValueKey('piece_$pieceNumber'));
    expect(pieceFinder, findsOneWidget);
    
    // Find the target slot (targetSlot is 0-3)
    final targetFinder = find.byKey(ValueKey('target_$targetSlot'));
    expect(targetFinder, findsOneWidget);
    
    // Get positions
    final pieceCenter = tester.getCenter(pieceFinder);
    final targetCenter = tester.getCenter(targetFinder);
    
    // Perform drag and drop
    final gesture = await tester.startGesture(pieceCenter, kind: PointerDeviceKind.touch);
    await tester.pump(const Duration(milliseconds: 100));
    
    // Move to target
    await gesture.moveTo(targetCenter);
    await tester.pump(const Duration(milliseconds: 100));
    
    // Complete gesture (drop)
    await gesture.up();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> verifyPuzzleComplete() async {
    // Wait for completion message
    await tester.pump(const Duration(milliseconds: 500));
    expect(puzzleCompleteText, findsOneWidget);
  }

  Future<void> completePuzzle() async {
    // Drag pieces 1, 2, 3, 4 to slots 0, 1, 2, 3 respectively
    await dragPieceToSlot(1, 0);
    await dragPieceToSlot(2, 1);
    await dragPieceToSlot(3, 2);
    await dragPieceToSlot(4, 3);
  }
}

