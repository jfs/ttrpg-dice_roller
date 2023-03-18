Feature: Dice Box
  As a player of table-top role-playing games
  I want to have a TUI tool and library for rolling dice
  So that I can build more tools for playing table-top role-playing games

  Scenario Outline: Echos a single integer
    When I run `dice-box roll <arg1>`
    Then the output should contain "<arg1>"
    And the exit status should be 0
    Examples:
      | arg1 |
      |    1 |
      |   11 |
      |  111 |
      | 1111 |
