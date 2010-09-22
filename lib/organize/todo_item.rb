module Organize
  class TODOItem
    
    attr_accessor :name, :complete, :tags
    DEFAULTS = {
      :complete => false,
      :tags => []
    }
    
    def initialize(name, options = {})
      self.name = name
      
      options = DEFAULTS.merge(options)
      self.complete = options[:complete]
      self.tags = options[:tags]
    end
    
    def complete?
      @complete
    end
    
    def incomplete?
      !complete?
    end
  end
end