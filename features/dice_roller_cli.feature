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

  Scenario: Multiply two integers with '*'
    When I run `roll 11*11`
    Then the output should contain exactly "121"
    And the exit status should be 0

  Scenario: Multiply two integers with 'x'
    When I run `roll 11x11`
    Then the output should contain exactly "121"
    And the exit status should be 0

  Scenario: Multiply two integers with 'X'
    When I run `roll 11X11`
    Then the output should contain exactly "121"
    And the exit status should be 0

  Scenario: Multiply two integers with '×'
    When I run `roll 11×11`
    Then the output should contain exactly "121"
    And the exit status should be 0

  Scenario: Multiply two integers with '⋅'
    When I run `roll 11⋅11`
    Then the output should contain exactly "121"
    And the exit status should be 0

  Scenario: Divide two integers with '/'
    When I run `roll 11/11`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Divide two integers with '÷'
    When I run `roll 11÷11`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Combine mixed operations
    When I run `roll 55+44-33*22/11`
    Then the output should contain exactly "33"
    And the exit status should be 0

  Scenario: Support operation precedence via parenthesis
    When I run `roll (55+44-33)×(22÷11)`
    Then the output should contain exactly "132"
    And the exit status should be 0
