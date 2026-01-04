import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:native_demo_app_automation/main.dart';
import '../../page_objects/home_page.dart';
import '../../page_objects/swipe_page.dart';
import '../../page_objects/drag_page.dart';

/// Step: Given I am on the main screen
StepDefinitionGeneric givenIAmOnMainScreen() {
  return given1<String, FlutterWorld>(
    'I am on the main screen',
    (step, context) async {
      final tester = context.world.appDriver;
      await tester.pumpWidget(const NativeDemoApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 2));
    },
  );
}

/// Step: When I click on the "{string}" option at the bottom
StepDefinitionGeneric whenIClickOnOptionAtBottom() {
  return when1<String, FlutterWorld>(
    'I click on the {string} option at the bottom',
    (option, context) async {
      final tester = context.world.appDriver;
      final homePage = HomePage(tester);
      
      if (option == 'Swipe') {
        await homePage.tapSwipeOption();
      } else if (option == 'Drag') {
        await homePage.tapDragOption();
      }
    },
  );
}

/// Step: Then I should see the swipe screen
StepDefinitionGeneric thenIShouldSeeSwipeScreen() {
  return then1<String, FlutterWorld>(
    'I should see the swipe screen',
    (step, context) async {
      final tester = context.world.appDriver;
      final swipePage = SwipePage(tester);
      await swipePage.verifySwipeScreen();
    },
  );
}

/// Step: When I perform a swipe left gesture
StepDefinitionGeneric whenIPerformSwipeLeft() {
  return when1<String, FlutterWorld>(
    'I perform a swipe left gesture',
    (step, context) async {
      final tester = context.world.appDriver;
      final swipePage = SwipePage(tester);
      await swipePage.swipeLeft();
    },
  );
}

/// Step: When I perform a swipe right gesture
StepDefinitionGeneric whenIPerformSwipeRight() {
  return when1<String, FlutterWorld>(
    'I perform a swipe right gesture',
    (step, context) async {
      final tester = context.world.appDriver;
      final swipePage = SwipePage(tester);
      await swipePage.swipeRight();
    },
  );
}

/// Step: Then I should see "{string}" as the last swipe direction
StepDefinitionGeneric thenIShouldSeeSwipeDirection() {
  return then1<String, FlutterWorld>(
    'I should see {string} as the last swipe direction',
    (direction, context) async {
      final tester = context.world.appDriver;
      final swipePage = SwipePage(tester);
      
      if (direction == 'Left') {
        await swipePage.verifySwipeLeft();
      } else if (direction == 'Right') {
        await swipePage.verifySwipeRight();
      }
    },
  );
}

/// Step: And I should be able to swipe left and swipe right on the application
StepDefinitionGeneric andIShouldBeAbleToSwipe() {
  return and1<String, FlutterWorld>(
    'I should be able to swipe left and swipe right on the application',
    (step, context) async {
      // This is already verified by the previous steps
      await Future.delayed(const Duration(seconds: 1));
    },
  );
}

/// Step: Then I should see the drag screen
StepDefinitionGeneric thenIShouldSeeDragScreen() {
  return then1<String, FlutterWorld>(
    'I should see the drag screen',
    (step, context) async {
      final tester = context.world.appDriver;
      final dragPage = DragPage(tester);
      await dragPage.verifyDragScreen();
    },
  );
}

/// Step: When I drag piece "{string}" to slot "{string}"
StepDefinitionGeneric whenIDragPieceToSlot() {
  return when2<String, String, FlutterWorld>(
    'I drag piece {string} to slot {string}',
    (pieceNumber, slotNumber, context) async {
      final tester = context.world.appDriver;
      final dragPage = DragPage(tester);
      await dragPage.dragPieceToSlot(int.parse(pieceNumber), int.parse(slotNumber));
    },
  );
}

/// Step: Then the puzzle should be complete
StepDefinitionGeneric thenPuzzleShouldBeComplete() {
  return then1<String, FlutterWorld>(
    'the puzzle should be complete',
    (step, context) async {
      final tester = context.world.appDriver;
      final dragPage = DragPage(tester);
      await dragPage.verifyPuzzleComplete();
    },
  );
}

/// Step: And I should see "{string}" message
StepDefinitionGeneric andIShouldSeeMessage() {
  return and1<String, FlutterWorld>(
    'I should see {string} message',
    (message, context) async {
      final tester = context.world.appDriver;
      expect(find.text(message), findsOneWidget);
      await Future.delayed(const Duration(seconds: 1));
    },
  );
}
