require_relative 'config/application'

Rails.application.load_tasks

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec_fast) do |t|
    t.pattern = 'spec/interactors/**/*_spec.rb'
  end
rescue LoadError # rubocop:disable Lint/HandleExceptions
  # no rspec available
end
