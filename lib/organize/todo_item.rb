module Organize
  class TODOItem
    
    attr_accessor :name, :status, :tags
    DEFAULTS = {
      :status => :incomplete,
      :tags => []
    }
    
    def initialize(name, options = {})
      self.name = name
      
      options = DEFAULTS.merge(options)
      self.status = options[:status]
      self.tags = options[:tags]
    end
    
    def complete?
      status == :complete
    end
    
    def incomplete?
      !complete?
    end
    
    def to_hash
      {
        name => {
          :status => status,
          :tags => tags
        }
      }
    end
  end
end