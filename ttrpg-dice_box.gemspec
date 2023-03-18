# frozen_string_literal: true

require_relative "lib/ttrpg/dice_box/version"

Gem::Specification.new do |spec|
  spec.name = "ttrpg-dice_box"
  spec.version = TTRPG::DiceBox::VERSION
  spec.authors = ["Jason Stahl"]
  spec.email = ["contact+#{spec.name}@mechjack.com"]

  spec.summary = "A dice rolling TUI and Ruby library."
  spec.description = "A dice rolling TUI and Ruby library powered by a rich dice notation grammar."
  spec.homepage = "https://gitlab.mechjack.com/jfs/#{spec.name}"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "http://jfs-syncthing.local"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "parslet", "~> 2"

  spec.add_development_dependency "aruba", "~> 2"
  spec.add_development_dependency "cucumber", "~> 8"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3"
  
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
