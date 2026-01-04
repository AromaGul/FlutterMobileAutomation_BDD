import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Page Object Model for Home Screen
class HomePage {
  final WidgetTester tester;

  HomePage(this.tester);

  // Locators
  Finder get mainScreenTitle => find.text('Main Screen');
  Finder get swipeOption => find.text('Swipe');
  Finder get dragOption => find.text('Drag');

  // Actions
  Future<void> verifyMainScreen() async {
    expect(mainScreenTitle, findsOneWidget);
  }

  Future<void> tapSwipeOption() async {
    expect(swipeOption, findsOneWidget);
    await tester.tap(swipeOption);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> tapDragOption() async {
    expect(dragOption, findsOneWidget);
    await tester.tap(dragOption);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

