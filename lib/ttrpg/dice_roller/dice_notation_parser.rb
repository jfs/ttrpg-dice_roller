# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    class DiceNotationParser < Parslet::Parser
      # whitespace
      rule(:space) { match('\s').repeat(1) }
      rule(:space?) { space.maybe }

      # literals
      rule(:integer) { match('\d').repeat(1).as(:integer) >> space? }

      # operators
      rule(:plus_op) { match('[+]') >> space? }
      rule(:minus_op) { match('[-]') >> space? }

      # operations
      rule(:addition) {
        integer.as(:left) >> plus_op.as(:plus_op) >> expression.as(:right)
      }
      rule(:subtraction) {
        integer.as(:left) >> minus_op.as(:minus_op) >> expression.as(:right)
      }

      # expression
      rule(:expression) { addition | subtraction | integer }
      root(:expression)
    end
  end
end
