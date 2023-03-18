# frozen_string_literal: true

require 'parslet'

module TTRPG
  module DiceRoller
    IntegerLiteral = Struct.new(:int) do
      def eval
        int.to_i
      end
    end

    Addition = Struct.new(:left, :right) do
      def eval
        left.eval + right.eval
      end
    end

    Subtraction = Struct.new(:left, :right) do
      def eval
        left.eval - right.eval
      end
    end

    class DiceNotationTransform < Parslet::Transform
      # literals
      rule(:integer => simple(:integer)) { IntegerLiteral.new(integer) }

      # operations
      rule(:left => simple(:left), :right => simple(:right),
          :plus_op => simple(:plus_op)) {
        Addition.new(left, right)
      }
      rule(:left => simple(:left), :right => simple(:right),
          :minus_op => simple(:minus_op)) {
        Subtraction.new(left, right)
      }
    end
  end
end
