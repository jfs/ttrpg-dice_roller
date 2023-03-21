# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    class DiceNotationParser < Parslet::Parser
      # grouping literals
      rule(:lparen) { str('(') }
      rule(:rparen) { str(')') }

      # dice notation literals
      rule(:die) { (str('d')) }
      rule(:from) { str('h') | str('l') }
      rule(:reduce) { str('k') | str('r') }
      rule(:compare) { str('a') | str('b') }

      # dice notation grammar
      rule(:pool) { pool_op.maybe.as(:count) >> die.as(:die) >> pool_op.as(:sides) }
      rule(:mods) { reduce.as(:reduce) >> from.maybe.as(:from) >> pool_op.maybe.as(:count) }
      rule(:target) { compare.as(:compare) >> pool_op.as(:threshold) }
      rule(:pool_op) { group | int }

      # operators
      rule(:plus) { str('+') }
      rule(:minus) { str('-') }
      rule(:times) { str('*') }
      rule(:divided_by) { str('/') }

      # operands
      rule(:group) { lparen >> exp.as(:group) >> rparen }
      rule(:notation) { pool.as(:pool) >> mods.repeat.as(:reduce) >> target.maybe.as(:target) }
      rule(:int) { match('\d').repeat(1).as(:int) }
      rule(:op) { group | notation | int }

      # statements
      rule(:add) { op.as(:left) >> plus.as(:plus) >> exp.as(:right) }
      rule(:subtract) { op.as(:left) >> minus.as(:minus) >> exp.as(:right) }
      rule(:multiply) { op.as(:left) >> times.as(:times) >> exp.as(:right) }
      rule(:divide) { op.as(:left) >> divided_by.as(:divided_by) >> exp.as(:right) }
      rule(:arithmetic) { add | subtract | multiply | divide }
      
      # expressions
      rule(:exp) { arithmetic | op | notation }
      root(:exp)
    end
  end
end
