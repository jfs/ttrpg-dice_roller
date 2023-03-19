# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    class DiceNotationParser < Parslet::Parser
      # whitespace
      rule(:space)  { match('\s').repeat(1) }
      rule(:space?) { space.maybe }

      # grouping literals
      rule(:lparen) { str('(') }
      rule(:rparen) { str(')') }

      # dice notation
      # rule(:dice_pool) { integer.maybe.as(:count) >> match('[dD]') >> integer.as(:sides) }
      # rule(:dice_notation) { dice_pool.as(:dice_pool) >> remove_dice.maybe.as(:remove_dice) }
      # rule(:remove_dice) { match('[rR]').as(:remove) >> integer.maybe.as(:count) >> (match('[hH]').as(:highest) | match('[hH]').as(:lowest))  }

      # operators
      rule(:op_addition) { str('+').as(:plus) }
      rule(:op_subtraction) { str('-').as(:minus) }
      rule(:op_multiplication) { str('*').as(:times) }
      rule(:op_division) { str('/').as(:divided_by) }

      # operands
      rule(:integer) { match('\d').repeat(1).as(:integer) }
      rule(:group)   { lparen >> space? >> expression.as(:group) >> space? >> rparen }
      rule(:operand) { group | integer }
      # rule(:operand) { group | dice_notation | integer }

      # statements
      rule(:addition) { operand.as(:left) >> space? >> op_addition >> space? >> expression.as(:right) }
      rule(:subtraction) { operand.as(:left) >> space? >> op_subtraction >> space? >> expression.as(:right) }
      rule(:multiplication) { operand.as(:left) >> space? >> op_multiplication >> space? >> expression.as(:right) }
      rule(:division) { operand.as(:left) >> space? >> op_division >> space? >> expression.as(:right) }
      rule(:arithmetic) { addition | subtraction | multiplication | division }
      
      # expression
      rule(:expression) { space? >> (arithmetic | operand) >> space? }
      root(:expression)
    end
  end
end
