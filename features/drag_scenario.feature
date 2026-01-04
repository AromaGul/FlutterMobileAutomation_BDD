Feature: Drag and Drop Functionality
  As a user
  I want to drag and drop puzzle pieces
  So that I can complete the picture puzzle

  Scenario: Complete the picture by dragging and dropping parts
    Given I am on the main screen
    When I click on the "Drag" option at the bottom
    Then I should see the drag screen
    When I drag piece "1" to slot "0"
    And I drag piece "2" to slot "1"
    And I drag piece "3" to slot "2"
    And I drag piece "4" to slot "3"
    Then the puzzle should be complete
    And I should see "Puzzle Complete!" message

