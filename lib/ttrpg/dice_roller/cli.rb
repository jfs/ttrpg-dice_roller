# frozen_string_literal: true

require_relative 'dice_notation_parser'
require_relative 'dice_notation_transform'

module TTRPG
  module DiceRoller
    class CLI
      def self.start(argv)
        begin
          tree = DiceNotationParser.new.parse(argv.join(' '))
          ast  = DiceNotationTransform.new.apply(tree)
          puts ast.eval
        rescue Parslet::ParseFailed => failure
          puts failure.parse_failure_cause.ascii_tree
          exit 1
        end
      end
    end
  end
end
