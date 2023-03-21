Feature: Dice Roller CLI
  As a player of table-top role-playing games
  I want to have a CLI tool for rolling dice
  So that I can build more tools for playing table-top role-playing games

  Background: Use sequence strategy for consistent test results
    Given I set the environment variables to:
      | variable                   | value    |
      | DICE_ROLLER_STRATEGY       | SEQUENCE |
      | DICE_ROLLER_SEQUENCE_COUNT | 0        |

  Scenario: Run command: roll 1
    When I run `roll 1`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Run command: roll 111
    When I run `roll 111`
    Then the output should contain exactly "111"
    And the exit status should be 0

  Scenario: Run command: roll 2+2
    When I run `roll 2+2`
    Then the output should contain exactly "4"
    And the exit status should be 0

  Scenario: Run command: roll 2+2+2
    When I run `roll 2+2+2`
    Then the output should contain exactly "6"
    And the exit status should be 0

  Scenario: Run command: roll 2-2
    When I run `roll 2-2`
    Then the output should contain exactly "0"
    And the exit status should be 0

  Scenario: Run command: roll 2-2-2
    When I run `roll 2-2-2`
    Then the output should contain exactly "2"
    And the exit status should be 0

  Scenario: Run command: roll 2+2-2
    When I run `roll 2+2-2`
    Then the output should contain exactly "2"
    And the exit status should be 0

  Scenario: Run command: roll 2*2
    When I run `roll 2*2`
    Then the output should contain exactly "4"
    And the exit status should be 0

  Scenario: Run command: roll 2*2*2
    When I run `roll 2*2*2`
    Then the output should contain exactly "8"
    And the exit status should be 0

  Scenario: Run command: roll 2+2-2*2
    When I run `roll 2+2-2*2`
    Then the output should contain exactly "0"
    And the exit status should be 0

  Scenario: Run command: roll 2/2
    When I run `roll 2/2`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Run command: roll 2/2/2
    When I run `roll 2/2/2`
    Then the output should contain exactly "2"
    And the exit status should be 0

  Scenario: Run command: roll 2+2-2*2/2
    When I run `roll 2+2-2*2/2`
    Then the output should contain exactly "2"
    And the exit status should be 0

  Scenario: Run command: roll ((((2+2)-2)*2)/2)
    When I run `roll ((((2+2)-2)*2)/2)`
    Then the output should contain exactly "2"
    And the exit status should be 0

  Scenario: Run command: roll d10
    When I run `roll d10`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Run command: roll 10d10
    When I run `roll 10d10`
    Then the output should contain exactly "55"
    And the exit status should be 0

  Scenario: Run command: roll 10*10d10
    When I run `roll 10*10d10`
    Then the output should contain exactly "550"
    And the exit status should be 0

  Scenario: Run command: roll 10d10r
    When I run `roll 10d10r`
    Then the output should contain exactly "54"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rl
    When I run `roll 10d10rl`
    Then the output should contain exactly "54"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rl2
    When I run `roll 10d10rl2`
    Then the output should contain exactly "52"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rh
    When I run `roll 10d10rh`
    Then the output should contain exactly "45"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rh2
    When I run `roll 10d10rh2`
    Then the output should contain exactly "36"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rl2rh2
    When I run `roll 10d10rl2rh2`
    Then the output should contain exactly "33"
    And the exit status should be 0

  Scenario: Run command: roll 10d10a8
    When I run `roll 10d10a8`
    Then the output should contain exactly "3"
    And the exit status should be 0

  Scenario: Run command: roll 10d10b8
    When I run `roll 10d10b8`
    Then the output should contain exactly "8"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rl2rh2a8
    When I run `roll 10d10rl2rh2a8`
    Then the output should contain exactly "1"
    And the exit status should be 0

  Scenario: Run command: roll (1d2)d10
    When I run `roll (1d2)d10`
    Then the output should contain exactly "2"
    And the exit status should be 0

  Scenario: Run command: roll 10d(3d6)
    When I run `roll 10d(3d6)`
    Then the output should contain exactly "37"
    And the exit status should be 0

  Scenario: Run command: roll 10d10rl(1d2)
    When I run `roll 10d10rl(1d2)`
    Then the output should contain exactly "54"
    And the exit status should be 0

  Scenario: Run command: roll 10d10a(2d2)
    When I run `roll 10d10a(2d2)`
    Then the output should contain exactly "8"
    And the exit status should be 0

  Scenario: Run command: roll (10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)
    When I run `roll (10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)`
    Then the output should contain exactly "48"
    And the exit status should be 0

