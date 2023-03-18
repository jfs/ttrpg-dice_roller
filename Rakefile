# frozen_string_literal: true

require 'rubygems'
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = ['--format pretty', '--publish-quiet']
end

task default: [:spec, :features]
