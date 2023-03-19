Feature: Dice Roller CLI
  As a player of table-top role-playing games
  I want to have a CLI tool for rolling dice
  So that I can build more tools for playing table-top role-playing games

  Scenario: Echo a single integer
    When I run `roll 11`
    Then the output should contain exactly "11"
    And the exit status should be 0

  Scenario: Add two integers
    When I run `roll 11+11`
    Then the output should contain exactly "22"
    And the exit status should be 0

  Scenario: Subtract two integers
    When I run `roll 11-11`
    Then the output should contain exactly "0"
    And the exit status should be 0

  Scenario: Multiply two integers
    When I run `roll 11*11`
    Then the output should contain exactly "121"
    And the exit status should be 0

  Scenario: Divide two integers
    When I run `roll 11/11`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Combine mixed operations
    When I run `roll 32 + 16 - 4 * 4 / 2`
    Then the output should contain exactly "40"
    And the exit status should be 0

  Scenario: Support operation precedence via parenthesis
    When I run `roll (((32 + 16) - 4) * 4) / 2`
    Then the output should contain exactly "88"
    And the exit status should be 0

  # Scenario: Roll a single die
  #   When I run `roll d6`
  #   Then the output should be an integer between "1" and "6"
  #   And the exit status should be 0

  # Scenario: Roll a group of dice
  #   When I run `roll 7d6`
  #   Then the output should be an integer between "7" and "42"
  #   And the exit status should be 0

  # Scenario: Roll a group of dice as part of arithmetic
  #   When I run `roll 10x7d6`
  #   Then the output should be an integer between "70" and "420"
  #   And the exit status should be 0

  # Scenario: Roll a group of dice and drop the 2 highest
  #   When I run `roll 10d10l2h`
  #   Then the output should be an integer between "80" and "800"
  #   And the exit status should be 0
