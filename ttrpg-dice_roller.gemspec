# frozen_string_literal: true

require_relative "lib/ttrpg/dice_roller/version"

Gem::Specification.new do |spec|
  spec.name = "ttrpg-dice_roller"
  spec.version = TTRPG::DiceRoller::VERSION
  spec.authors = ["Jason Stahl"]
  spec.email = ["contact+#{spec.name}@mechjack.com"]

  spec.summary = "A dice rolling CLI and Ruby library."
  spec.description = "A dice rolling CLI and Ruby library powered by a rich dice notation grammar."
  spec.homepage = "https://github.com/jfs/#{spec.name}"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
      f.start_with?(*%w[bin/ features/ spec/ .git .rspec Rakefile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet", "~> 2"
  spec.add_development_dependency "aruba", "~> 2"
  spec.add_development_dependency "cucumber", "~> 8"
  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3"
end
