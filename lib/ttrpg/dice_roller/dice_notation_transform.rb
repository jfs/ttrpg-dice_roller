# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    # operands
    ExpressionGroup = Struct.new(:group) { def eval; group.eval; end }
    IntegerLiteral = Struct.new(:int)    { def eval; int.to_i; end }

    # operations
    Addition = Struct.new(:left, :right)       { def eval; left.eval + right.eval; end }
    Division = Struct.new(:left, :right)       { def eval; left.eval / right.eval; end }
    Multiplication = Struct.new(:left, :right) { def eval; left.eval * right.eval; end }
    Subtraction = Struct.new(:left, :right)    { def eval; left.eval - right.eval; end }

    class DiceNotationTransform < Parslet::Transform
      # operands
      rule(:group => simple(:group)) { ExpressionGroup.new(group) }
      rule(:integer => simple(:integer)) { IntegerLiteral.new(integer) }

      # operations
      rule(:left => simple(:left), :right => simple(:right), :a => simple(:a)) { Addition.new(left, right) }
      rule(:left => simple(:left), :right => simple(:right), :s => simple(:s)) { Subtraction.new(left, right) }
      rule(:left => simple(:left), :right => simple(:right), :m => simple(:m)) { Multiplication.new(left, right) }
      rule(:left => simple(:left), :right => simple(:right), :d => simple(:d)) { Division.new(left, right) }      
    end
  end
end
