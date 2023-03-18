# frozen_string_literal: true

module TTRPG
  module DiceRoller
    class CLI
      def self.start(argv)
        begin
          puts TTRPG::DiceRoller.roll(argv.join(' '))
        rescue Parslet::ParseFailed => failure
          puts failure.parse_failure_cause.ascii_tree
          exit 1
        end
      end
    end
  end
end
