import 'dart:async';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_demo_app_automation/main.dart';
import '../test/page_objects/home_page.dart';
import '../test/page_objects/swipe_page.dart';
import '../test/page_objects/drag_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Native Demo App Automation', () {
    testWidgets('Scenario 1: Swipe left and right', (WidgetTester tester) async {
      // Launch app
      await tester.pumpWidget(const NativeDemoApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));

      // Initialize Page Objects
      final homePage = HomePage(tester);
      final swipePage = SwipePage(tester);

      // Verify main screen
      await homePage.verifyMainScreen();

      // Click on Swipe option at the bottom
      await homePage.tapSwipeOption();
      await Future.delayed(const Duration(seconds: 2));

      // Verify swipe screen
      await swipePage.verifySwipeScreen();

      // Perform swipe left
      await swipePage.swipeLeft();
      await Future.delayed(const Duration(seconds: 1));
      await swipePage.verifySwipeLeft();

      // Perform swipe right
      await swipePage.swipeRight();
      await Future.delayed(const Duration(seconds: 1));
      await swipePage.verifySwipeRight();

      // Assertions: Users should be able to swipe left and swipe right
      await Future.delayed(const Duration(seconds: 2));
    });

    testWidgets('Scenario 2: Drag and drop to complete picture', (WidgetTester tester) async {
      // Launch app
      await tester.pumpWidget(const NativeDemoApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));

      // Initialize Page Objects
      final homePage = HomePage(tester);
      final dragPage = DragPage(tester);

      // Verify main screen
      await homePage.verifyMainScreen();

      // Click on Drag option at the bottom
      await homePage.tapDragOption();
      await Future.delayed(const Duration(seconds: 2));

      // Verify drag screen
      await dragPage.verifyDragScreen();

      // Complete the picture by dragging and dropping the parts
      await dragPage.completePuzzle();
      await Future.delayed(const Duration(seconds: 2));

      // Assertions: Puzzle should be complete
      await dragPage.verifyPuzzleComplete();
      await Future.delayed(const Duration(seconds: 2));
    });
  });
}

