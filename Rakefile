require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec

task :autospec do
  system 'bundle exec watchr spec/autospec.watchr'
end