Feature: Dice Roller CLI
  As a player of table-top role-playing games
  I want to have a CLI tool for rolling dice
  So that I can build more tools for playing table-top role-playing games

  Background: Use sequence strategy for consistent test results
    Given I set the environment variables to:
      | variable                   | value    |
      | DICE_ROLLER_STRATEGY       | SEQUENCE |
      | DICE_ROLLER_SEQUENCE_COUNT | 0        |

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
    When I run `roll 10d10`
    Then the output should contain exactly "55"
    And the exit status should be 0

  Scenario: Rolls a dice pool as part of arithmetic
    When I run `roll 10*10d10`
    Then the output should contain exactly "550"
    And the exit status should be 0

  Scenario: Rolls a dice pool with implied count of 1
    When I run `roll d10`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes the 2 highest values
    When I run `roll 10d10r2h`
    Then the output should contain exactly "36"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes an implied 1 highest value
    When I run `roll 10d10rh`
    Then the output should contain exactly "45"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes the 2 lowest values
    When I run `roll 10d10r2l`
    Then the output should contain exactly "52"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes an implied 1 lowest value
    When I run `roll 10d10rl`
    Then the output should contain exactly "54"
    And the exit status should be 0

  Scenario: Rolls a dice pool that removes the 2 highest and lowest values
    When I run `roll 10d10r2hr2l`
    Then the output should contain exactly "33"
    And the exit status should be 0
