module Organize
  class Project
    
    attr_reader :prefix, :shared_prefix, :name
    
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
    
    def create
      FileUtils.mkdir_p(path)
      FileUtils.mkdir_p(shared_path)
      FileUtils.mkdir_p(archive_path)
      FileUtils.mkdir_p(project_archive_path)
      
      unless File.exists?(shared_link_path)
        FileUtils.ln_s(shared_path, shared_link_path)
      end
    end
    
    def archive
      FileUtils.mv(path, project_archive_path)
    end
  end
end