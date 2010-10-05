require 'optitron'

module Organize
  class Runner < Optitron::CLI
    desc 'Install stuff'
    def install(file, source = '.')
      # TODO: Make this method create the prefix, shared prefix, the .organize
      # file, the other folder (with all its symlinks), the Inbox -> Desktop
      # folder, and project archive folder.
    end
  end
end