# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    # operands
    DiceCode        = Struct.new(:count, :sides) {
      def eval
        evaled_count = count != nil ? count.eval : 1
        rolls = []
        evaled_count.times do
          rolls << rand(1..sides.eval)
        end
        return rolls
      end
    }
    DiceNotation    = Struct.new(:dice_code) {
      def eval
        total = 0
        dice_code.eval.each do |value|
          total += value
        end
        return total
      end
    }
    ExpressionGroup = Struct.new(:group)         { def eval; group.eval; end }
    IntegerLiteral  = Struct.new(:integer)       { def eval; integer.to_i; end }

    # operations
    Addition       = Struct.new(:left, :right) { def eval; left.eval + right.eval; end }
    Division       = Struct.new(:left, :right) { def eval; left.eval / right.eval; end }
    Multiplication = Struct.new(:left, :right) { def eval; left.eval * right.eval; end }
    Subtraction    = Struct.new(:left, :right) { def eval; left.eval - right.eval; end }

    class DiceNotationTransform < Parslet::Transform
      # operands
      rule(:group => simple(:group)) { ExpressionGroup.new(group) }
      rule(:integer => simple(:integer)) { IntegerLiteral.new(integer) }
      rule(:count => simple(:count), :sides => simple(:sides)) { DiceCode.new(count, sides) }
      rule(:dice_code => simple(:dice_code)) { DiceNotation.new(dice_code) }

      # operations
      rule(:left => simple(:left), :right => simple(:right), :a => simple(:a)) { Addition.new(left, right) }
      rule(:left => simple(:left), :right => simple(:right), :s => simple(:s)) { Subtraction.new(left, right) }
      rule(:left => simple(:left), :right => simple(:right), :m => simple(:m)) { Multiplication.new(left, right) }
      rule(:left => simple(:left), :right => simple(:right), :d => simple(:d)) { Division.new(left, right) }      
    end
  end
end
