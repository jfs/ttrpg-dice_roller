# frozen_string_literal: true

require 'parslet'
require_relative 'strategy'

module TTRPG
  module DiceRoller
    # dice notation
    Pool = Struct.new(:count, :die, :sides) {
      def roll
        evaled_count = count != nil ? count.eval : 1
        evaled_sides = sides.eval
        rolls = []

        evaled_count.times do
          case ENV['DICE_ROLLER_STRATEGY']
          when TTRPG::DiceRoller::SEQUENCE
            ENV['DICE_ROLLER_SEQUENCE_COUNT'] ||= '0'
            evaled_sides = evaled_sides
            rolls << (1..evaled_sides).to_a[ENV['DICE_ROLLER_SEQUENCE_COUNT'].to_i % evaled_sides]
            ENV['DICE_ROLLER_SEQUENCE_COUNT'] = "#{(ENV['DICE_ROLLER_SEQUENCE_COUNT'].to_i + 1).to_s}"
          else
            rolls << rand(1..evaled_sides)
          end
        end
        return rolls
      end
    }

    Reduce = Struct.new(:remove, :from, :count) {
      def remove(pool)
        evaled_count = count != nil ? count.eval : 1
        evaled_from = from != nil ? from.str : 'l'
        
        pool.sort!
        evaled_count.times do
          ('h'.eql?(evaled_from) ? pool.pop : pool.shift) if pool.size > 0
        end
        return pool
      end
    }

    Target = Struct.new(:compare, :threshold) {
      def eval(pool)
        successes = 0
        evaled_threshold = threshold.eval

        pool.each do |die|
          case compare.str
          when 'a'
            successes += 1 if die >= evaled_threshold
          else
            successes += 1 if die <= evaled_threshold
          end
        end
        return successes
      end
    }

    # operands
    ExpressionGroup = Struct.new(:group) {
      def eval
        group.eval
      end
    }

    Notation = Struct.new(:pool, :reduce, :target) {
      def eval
        dice = pool.roll

        reduce.each do |mod|
          dice = mod.remove(dice)
        end
        if target != nil
          return target.eval(dice)
        else
          dice_total = 0

          dice.each do |die|
            dice_total += die
          end
          return dice_total
        end
      end
    }

    IntegerLiteral = Struct.new(:int) {
      def eval
        int.to_i
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
      }) { Pool.new(count, die, sides) }
    
      rule({
        reduce: simple(:reduce),
        from: simple(:from),
        count: simple(:count)
      }) { Reduce.new(reduce, from, count) }
    
      rule({
        compare: simple(:compare),
        threshold: simple(:threshold)
      }) { Target.new(compare, threshold) }
    
      # operands
      rule({
        group: simple(:group)
      }) { ExpressionGroup.new(group) }
    
      rule({
        pool: simple(:pool),
        reduce: sequence(:reduce),
        target: simple(:target)
      }) { Notation.new(pool, reduce, target) }

      rule({
        int: simple(:int)
      }) { IntegerLiteral.new(int) }

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
