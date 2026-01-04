import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

/// Page Object Model for Swipe Screen
class SwipePage {
  final WidgetTester tester;

  SwipePage(this.tester);

  // Locators
  Finder get swipeScreenTitle => find.text('Swipe Screen');
  Finder get swipeDirectionText => find.byKey(ValueKey('swipe_direction'));
  Finder get swipeContainer => find.byKey(ValueKey('swipe_container'));

  // Actions
  Future<void> verifySwipeScreen() async {
    expect(swipeScreenTitle, findsOneWidget);
  }

  Future<void> swipeLeft() async {
    // Find the swipe container
    expect(swipeContainer, findsOneWidget);
    
    final center = tester.getCenter(swipeContainer);
    
    // Perform swipe left using drag - drag from center to left with sufficient distance
    await tester.drag(swipeContainer, Offset(-250, 0), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> swipeRight() async {
    // Find the swipe container
    expect(swipeContainer, findsOneWidget);
    
    final center = tester.getCenter(swipeContainer);
    
    // Perform swipe right using drag - drag from center to right with sufficient distance
    await tester.drag(swipeContainer, Offset(250, 0), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> verifySwipeLeft() async {
    // Wait a bit for state to update
    await tester.pump(const Duration(milliseconds: 500));
    final directionText = tester.widget<Text>(swipeDirectionText);
    expect(directionText.data, contains('Left'));
  }

  Future<void> verifySwipeRight() async {
    // Wait a bit for state to update
    await tester.pump(const Duration(milliseconds: 500));
    final directionText = tester.widget<Text>(swipeDirectionText);
    expect(directionText.data, contains('Right'));
  }
}

