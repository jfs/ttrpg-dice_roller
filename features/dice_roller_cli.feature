Feature: Dice Roller CLI
  As a player of table-top role-playing games
  I want to have a CLI tool for rolling dice
  So that I can build more tools for playing table-top role-playing games

  Scenario: Echo a single integer
    When I run `roll 11`
    Then the output should contain "11"
    And the exit status should be 0

  Scenario: Add two integers
    When I run `roll 11+11`
    Then the output should contain "22"
    And the exit status should be 0

  Scenario: Subtract two integers
    When I run `roll 11-11`
    Then the output should contain "0"
    And the exit status should be 0

  Scenario: Multiply two integers
    When I run `roll 11*11`
    Then the output should contain "121"
    And the exit status should be 0

  Scenario: Divide two integers
    When I run `roll 11/11`
    Then the output should contain "1"
    And the exit status should be 0
