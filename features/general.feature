Feature: General Functions
  Help methods

  Scenario: Help Menu
    When I get "help"
    Then the exit status should be 0

  Scenario: Version
    When I get "--version"
    Then the exit status should be 0
