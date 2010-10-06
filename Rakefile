require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :rspec

def gemspec
  file = 'organize.gemspec'
  @gemspec ||= eval(File.read(file), binding, file)
end

desc 'Build the gem'
task :gem do
  sh 'gem build organize.gemspec'
  mv "#{gemspec.full_name}.gem", 'pkg'
end

desc 'Install organize'
task :install => :gem do
  sh "gem install pkg/#{gemspec.full_name}.gem"
end