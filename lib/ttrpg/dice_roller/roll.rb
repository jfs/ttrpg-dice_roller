# frozen_string_literal: true

require_relative 'dice_notation_parser'
require_relative 'dice_notation_transform'

module TTRPG
  module DiceRoller
    def roll(dice_notation)
      tree = DiceNotationParser.new.parse(dice_notation)
      ast  = DiceNotationTransform.new.apply(tree)
      ast.eval
    end
    module_function :roll
  end
end
