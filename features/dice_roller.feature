Feature: Dice Box
  As a player of table-top role-playing games
  I want to have a TUI tool and library for rolling dice
  So that I can build more tools for playing table-top role-playing games

  Scenario Outline: Echo a single integer
    When I run `roll <arg1>`
    Then the output should contain "<arg1>"
    And the exit status should be 0
    Examples:
      | arg1 |
      |    1 |
      |   11 |
      |  111 |
      | 1111 |

  Scenario Outline: Add two integers
    When I run `roll <arg1> + <arg2>`
    Then the output should contain "<result>"
    And the exit status should be 0
    Examples:
      | arg1 | arg2 | result |
      |    1 |    1 |      2 |
      |   11 |   11 |     22 |
      |  111 |  111 |    222 |
      | 1111 | 1111 |   2222 |

  Scenario Outline: Subtract two integers
    When I run `roll <arg1> - <arg2>`
    Then the output should contain "<result>"
    And the exit status should be 0
    Examples:
      | arg1 | arg2 | result |
      |    3 |    2 |      1 |
      |   33 |   22 |     11 |
      |  333 |  222 |    111 |
      | 3333 | 2222 |   1111 |
