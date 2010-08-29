require 'optitron'

module Organize
  class Runner < Optitron::CLI
    desc 'Install stuff'
    opt 'force'
    def install(file, source = ".")
      puts "Installing #{file} from #{source.inspect} with params: #{params.inspect}"
    end
  end
end