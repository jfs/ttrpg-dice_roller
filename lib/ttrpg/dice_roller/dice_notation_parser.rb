# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    class DiceNotationParser < Parslet::Parser
      # literals
      rule(:integer) { match('\d').repeat(1).as(:integer) }
      rule(:space)  { match('\s').repeat(1) }
      rule(:space?) { space.maybe }
      rule(:lparen) { str('(') >> space? }
      rule(:rparen) { space? >> str(')') }

      # dice notation
      rule(:dice_code) { integer.maybe.as(:count) >> match('[dD]') >> integer.as(:sides) }
      rule(:dice_notation) { dice_code.as(:dice_code) }

      # operators
      rule(:op_a) { space? >> match('[+]') >> space? }
      rule(:op_s) { space? >> match('[-]') >> space? }
      rule(:op_m) { space? >> match('[*xX×⋅]') >> space? }
      rule(:op_d) { space? >> match('[/÷]') >> space? }

      # arithmetic
      rule(:addition)       { operand.as(:left) >> op_a.as(:a) >> expression.as(:right) }
      rule(:subtraction)    { operand.as(:left) >> op_s.as(:s) >> expression.as(:right) }
      rule(:multiplication) { operand.as(:left) >> op_m.as(:m) >> expression.as(:right) }
      rule(:division)       { operand.as(:left) >> op_d.as(:d) >> expression.as(:right) }
      rule(:arithmetic)     { addition | subtraction | multiplication | division }

      # grammar
      rule(:group)   { lparen >> expression.as(:group) >> rparen }
      rule(:operand) { group | dice_notation | integer }
      
      # expression
      rule(:expression) { arithmetic | operand }
      root(:expression)
    end
  end
end
