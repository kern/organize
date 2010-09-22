module Organize
  class TODOItem
    
    attr_accessor :name, :complete
    DEFAULTS = {
      :complete => false
    }
    
    def initialize(name, options = {})
      self.name = name
      
      options = DEFAULTS.merge(options)
      self.complete = options[:complete]
    end
    
    def complete?
      @complete
    end
    
    def incomplete?
      !complete?
    end
  end
end