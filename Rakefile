require_relative 'config/application'
require 'rspec/core/rake_task'

Rails.application.load_tasks

RSpec::Core::RakeTask.new(:spec_fast) do |t|
  t.pattern = 'spec/interactors/**/*_spec.rb'
end
