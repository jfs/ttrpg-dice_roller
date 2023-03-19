# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    # dice notation
    DicePool = Struct.new(:count, :die, :sides) {
      def roll
        evaled_count = count != nil ? count.eval : 1
        rolls = []

        evaled_count.times do
          rolls << rand(1..sides.eval)
        end
        return rolls
      end
    }

    RemoveHighest = Struct.new(:remove, :count, :highest) {
      def remove(dice_pool)
        evaled_count = count != nil ? count.eval : 1
        
        dice_pool.sort!
        evaled_count.times do
          dice_pool.pop if dice_pool.size > 0
        end
        return dice_pool
      end
    }

    RemoveLowest = Struct.new(:remove, :count, :lowest) {
      def remove(dice_pool)
        evaled_count = count != nil ? count.eval : 1
        
        dice_pool.sort!
        evaled_count.times do
          dice_pool.shift if dice_pool.size > 0
        end
        return dice_pool
      end
    }

    # operands
    ExpressionGroup = Struct.new(:group) {
      def eval
        group.eval
      end
    }

    DiceNotation = Struct.new(:dice_pool, :remove_highest, :remove_lowest) {
      def eval
        final_result = 0
        dice_rolls = dice_pool.roll
        dice_rolls = remove_highest.remove(dice_rolls) if remove_highest
        dice_rolls = remove_lowest.remove(dice_rolls) if remove_lowest

        dice_rolls.each do |value|
          final_result += value
        end
        return final_result
      end
    }

    IntegerLiteral = Struct.new(:integer) {
      def eval
        integer.to_i
      end
    }

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
      # dice notation
      rule({
        count: simple(:count),
        die: simple(:die),
        sides: simple(:sides)
      }) { DicePool.new(count, die, sides) }
    
      rule({
        remove: simple(:remove),
        count: simple(:count),
        highest: simple(:highest)
      }) { RemoveHighest.new(remove, count, highest) }
    
      rule({
        remove: simple(:remove),
        count: simple(:count),
        lowest: simple(:lowest)
      }) { RemoveLowest.new(remove, count, lowest) }
    
      # operands
      rule({
        group: simple(:group)
      }) { ExpressionGroup.new(group) }
    
      rule({
        dice_pool: simple(:dice_pool),
        remove_highest: simple(:remove_highest),
        remove_lowest: simple(:remove_lowest)
      }) { DiceNotation.new(dice_pool, remove_highest, remove_lowest) }

      rule({
        integer: simple(:integer)
      }) { IntegerLiteral.new(integer) }
    
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
