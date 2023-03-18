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
      rule(:divide_op) { match('[/]') >> space? }
      
      rule(:plus_op) { match('[+]') >> space? }
      
      rule(:minus_op) { match('[-]') >> space? }
      
      rule(:times_op) { match('[*]') >> space? }

      # operations
      rule(:addition) {
        integer.as(:left) >> plus_op.as(:plus_op) >> expression.as(:right)
      }
      
      rule(:division) {
        integer.as(:left) >> divide_op.as(:divide_op) >> expression.as(:right)
      }

      rule(:multiplication) {
        integer.as(:left) >> times_op.as(:times_op) >> expression.as(:right)
      }
      
      rule(:subtraction) {
        integer.as(:left) >> minus_op.as(:minus_op) >> expression.as(:right)
      }

      # expression
      rule(:arithmetic) { addition | subtraction | multiplication | division }
      rule(:expression) { arithmetic | integer }
      
      root(:expression)
    end
  end
end
