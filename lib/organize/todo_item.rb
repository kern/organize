module Organize
  class TODOItem
    
    attr_accessor :name
    
    def initialize(name)
      self.name = name
      self
    end
    
    def complete?
      @complete
    end
  end
end