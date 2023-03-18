# frozen_string_literal: true

module TTRPG
  module DiceBox
    class CLI
      def self.start(argv)
        'roll'.eql? argv.shift ? puts(argv.shift) : exit(1)
      end
    end
  end
end
