module Organize
  class Project
    
    attr_reader :prefix
    attr_accessor :name
    
    DEFAULT_PREFIX = '~/Projects'
    
    def initialize(name, prefix = DEFAULT_PREFIX)
      @name = name
      @prefix = prefix
    end
    
    def path
      File.join(prefix, name)
    end
  end
end