module Organize
  class Project
    
    attr_reader :prefix, :shared_prefix
    attr_accessor :name
    
    DEFAULTS = {
      :prefix => '~/Projects',
      :shared_prefix => '~/Dropbox'
    }
    
    def initialize(name, options = {})
      @name = name
      
      options = DEFAULTS.merge(options)
      @prefix = options[:prefix]
      @shared_prefix = options[:shared_prefix]
    end
    
    def path
      File.join(prefix, name)
    end
    
    def archive_path
      File.join(path, 'Archive')
    end
    
    def shared_path
      File.join(shared_prefix, name)
    end
    
    def shared_link_path
      File.join(path, 'Shared')
    end
    
    def project_archive_path
      File.join(prefix, 'Archive')
    end
  end
end