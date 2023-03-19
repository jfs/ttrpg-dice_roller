# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    # operands
    IntegerLiteral = Struct.new(:integer) {
      def eval
        integer.to_i
      end
    }

    ExpressionGroup = Struct.new(:group) {
      def eval
        group.eval
      end
    }

    # DiceNotation    = Struct.new(:dice_code) {
    #   def eval
    #     total = 0
    #     dice_code.eval.each do |value|
    #       total += value
    #     end
    #     return total
    #   end
    # }

    # DicePool        = Struct.new(:count, :sides) {
    #   def eval
    #     evaled_count = count != nil ? count.eval : 1
    #     rolls = []
    #     evaled_count.times do
    #       rolls << rand(1..sides.eval)
    #     end
    #     return rolls
    #   end
    # }

    # operations
    Addition = Struct.new(:left, :right) {
      def eval
        left.eval + right.eval
      end
    }

    Subtraction = Struct.new(:left, :right) {
      def eval
        left.eval - right.eval
      end
    }

    Multiplication = Struct.new(:left, :right) {
      def eval
        left.eval * right.eval
      end
    }

    Division = Struct.new(:left, :right) {
      def eval
        left.eval / right.eval
      end
    }

    class DiceNotationTransform < Parslet::Transform
      # operands
      rule({
        integer: simple(:integer)
      }) { IntegerLiteral.new(integer) }
    
      rule({
        :group => simple(:group)
      }) { ExpressionGroup.new(group) }
    
      # rule(:count => simple(:count), :sides => simple(:sides)) { DicePool.new(count, sides) }
    
      # rule(:dice_pool => simple(:dice_pool)) { DiceNotation.new(dice_pool) }

      # operations
      rule({
        left: simple(:left),
        plus: simple(:plus),
        right: simple(:right)
      }) { Addition.new(left, right) }
    
      rule({
        left: simple(:left),
        minus: simple(:minus),
        right: simple(:right)
      }) { Subtraction.new(left, right) }
    
      rule({
        left: simple(:left),
        times: simple(:times),
        right: simple(:right)
      }) { Multiplication.new(left, right) }
    
      rule({
        left: simple(:left),
        divided_by: simple(:divided_by),
        right: simple(:right)
      }) { Division.new(left, right) }
    end
  end
end
