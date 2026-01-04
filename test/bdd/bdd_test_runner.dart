import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:integration_test/integration_test.dart';
import 'step_definitions/app_steps.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final config = FlutterTestConfiguration()
    ..features = [RegExp(r'features/.*\.feature$')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json'),
    ]
    ..stepDefinitions = [
      givenIAmOnMainScreen(),
      whenIClickOnOptionAtBottom(),
      thenIShouldSeeSwipeScreen(),
      whenIPerformSwipeLeft(),
      whenIPerformSwipeRight(),
      thenIShouldSeeSwipeDirection(),
      andIShouldBeAbleToSwipe(),
      thenIShouldSeeDragScreen(),
      whenIDragPieceToSlot(),
      thenPuzzleShouldBeComplete(),
      andIShouldSeeMessage(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..exitAfterTestRun = true;

  final runner = GherkinRunner(config);
  await runner.execute();
}

