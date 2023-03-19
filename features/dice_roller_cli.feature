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
    When I run `roll 32+16-4*4/2`
    Then the output should contain exactly "40"
    And the exit status should be 0

  Scenario: Support operation precedence via parenthesis
    When I run `roll (((32+16)-4)*4)/2`
    Then the output should contain exactly "88"
    And the exit status should be 0

  Scenario: Rolls a dice pool
    When I run `roll 10d1`
    Then the output should contain exactly "10"
    And the exit status should be 0

  Scenario: Rolls a dice pool as part of arithmetic
    When I run `roll 10*10d1`
    Then the output should contain exactly "100"
    And the exit status should be 0

  Scenario: Rolls a dice pool with implied count of 1
    When I run `roll d1`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes the 2 highest values
    When I run `roll 10d1r2h`
    Then the output should contain exactly "8"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes an implied 1 highest value
    When I run `roll 10d1rh`
    Then the output should contain exactly "9"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes the 2 lowest values
    When I run `roll 10d1r2l`
    Then the output should contain exactly "8"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes an implied 1 lowest value
    When I run `roll 10d1rl`
    Then the output should contain exactly "9"
    And the exit status should be 0
