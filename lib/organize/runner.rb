require 'optitron'
require 'yaml'
require 'fileutils'

module Organize
  class Runner < Optitron::CLI
    desc 'Install organize to your home directory.'
    def install
      prefix        = Project::PREFIX
      shared_prefix = Project::SHARED_PREFIX
      
      # Create the prefix and shared prefix.
      FileUtils.mkdir_p(prefix)
      FileUtils.mkdir_p(File.join(prefix, 'Archive'))
      FileUtils.mkdir_p(shared_prefix)
      
      # Create Inbox pseudo-project
      inbox             = File.join(prefix, 'Inbox')
      inbox_shared      = File.join(shared_prefix, 'Inbox')
      inbox_shared_link = File.join(inbox, 'Shared')
      
      FileUtils.ln_s(File.expand_path('~/Desktop'), inbox) unless File.exists?(inbox)
      FileUtils.mkdir_p(inbox_shared)
      FileUtils.ln_s(inbox_shared, inbox_shared_link) unless File.exists?(inbox_shared_link)
      
      # Create the Other project
      other = Project.new('Other')
      other.create
      
      %w{Documents Movies Music Pictures Public Sites}.each do |directory|
        old_directory = File.expand_path("~/#{directory}")
        new_directory = File.join(other.path, directory)
        FileUtils.ln_s(old_directory, new_directory) unless File.exists?(new_directory)
      end
    end
    
    desc 'Creates a new project.'
    def create(name)
      Project.new(name).create
    end
  end
end