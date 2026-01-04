Feature: Swipe Functionality
  As a user
  I want to perform swipe gestures
  So that I can interact with the swipe screen

  Scenario: Swipe left and right on the application
    Given I am on the main screen
    When I click on the "Swipe" option at the bottom
    Then I should see the swipe screen
    When I perform a swipe left gesture
    Then I should see "Left" as the last swipe direction
    When I perform a swipe right gesture
    Then I should see "Right" as the last swipe direction
    And I should be able to swipe left and swipe right on the application

