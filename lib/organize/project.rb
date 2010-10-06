module Organize
  class Project
    
    attr_reader :name
    PREFIX = File.expand_path('~/Projects')
    SHARED_PREFIX = File.expand_path('~/Dropbox')
    
    def initialize(name)
      @name = name
    end
    
    def path
      File.join(PREFIX, name)
    end
    
    def archive_path
      File.join(path, 'Archive')
    end
    
    def shared_path
      File.join(SHARED_PREFIX, name)
    end
    
    def shared_link_path
      File.join(path, 'Shared')
    end
    
    def project_archive_path
      File.join(PREFIX, 'Archive')
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
  end
end