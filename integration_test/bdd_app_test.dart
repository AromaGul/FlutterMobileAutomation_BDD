import 'dart:async';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_demo_app_automation/main.dart';
import '../test/page_objects/home_page.dart';
import '../test/page_objects/swipe_page.dart';
import '../test/page_objects/drag_page.dart';

/// BDD-style test runner for Native Demo App
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('BDD: Swipe Functionality', () {
    testWidgets('Scenario: Swipe left and right on the application', (WidgetTester tester) async {
      // Given I am on the main screen
      await tester.pumpWidget(const NativeDemoApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));

      final homePage = HomePage(tester);
      await homePage.verifyMainScreen();

      // When I click on the "Swipe" option at the bottom
      await homePage.tapSwipeOption();
      await Future.delayed(const Duration(seconds: 2));

      // Then I should see the swipe screen
      final swipePage = SwipePage(tester);
      await swipePage.verifySwipeScreen();

      // When I perform a swipe left gesture
      await swipePage.swipeLeft();
      await Future.delayed(const Duration(seconds: 1));

      // Then I should see "Left" as the last swipe direction
      await swipePage.verifySwipeLeft();

      // When I perform a swipe right gesture
      await swipePage.swipeRight();
      await Future.delayed(const Duration(seconds: 1));

      // Then I should see "Right" as the last swipe direction
      await swipePage.verifySwipeRight();

      // And I should be able to swipe left and swipe right on the application
      await Future.delayed(const Duration(seconds: 2));
    });
  });

  group('BDD: Drag and Drop Functionality', () {
    testWidgets('Scenario: Complete the picture by dragging and dropping parts', (WidgetTester tester) async {
      // Given I am on the main screen
      await tester.pumpWidget(const NativeDemoApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));

      final homePage = HomePage(tester);
      await homePage.verifyMainScreen();

      // When I click on the "Drag" option at the bottom
      await homePage.tapDragOption();
      await Future.delayed(const Duration(seconds: 2));

      // Then I should see the drag screen
      final dragPage = DragPage(tester);
      await dragPage.verifyDragScreen();

      // When I drag piece "1" to slot "0"
      await dragPage.dragPieceToSlot(1, 0);
      await Future.delayed(const Duration(milliseconds: 500));

      // And I drag piece "2" to slot "1"
      await dragPage.dragPieceToSlot(2, 1);
      await Future.delayed(const Duration(milliseconds: 500));

      // And I drag piece "3" to slot "2"
      await dragPage.dragPieceToSlot(3, 2);
      await Future.delayed(const Duration(milliseconds: 500));

      // And I drag piece "4" to slot "3"
      await dragPage.dragPieceToSlot(4, 3);
      await Future.delayed(const Duration(seconds: 1));

      // Then the puzzle should be complete
      await dragPage.verifyPuzzleComplete();

      // And I should see "Puzzle Complete!" message
      expect(find.byKey(ValueKey('puzzle_complete')), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });
  });
}

