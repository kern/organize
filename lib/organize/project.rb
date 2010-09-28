module Organize
  class Project
    
    attr_reader :prefix, :shared_prefix
    attr_accessor :name, :todos
    
    DEFAULTS = {
      :prefix => '~/Projects',
      :shared_prefix => '~/Dropbox',
      :todos => []
    }
    
    def initialize(name, options = {})
      self.name = name
      
      options = DEFAULTS.merge(options)
      @prefix = options[:prefix]
      @shared_prefix = options[:shared_prefix]
      self.todos = options[:todos]
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
    
    def todo_path
      File.join(shared_path, 'TODO')
    end
    
    def complete_todos
      todos.select { |todo| todo.complete? }
    end
    
    def incomplete_todos
      todos.select { |todo| todo.incomplete? }
    end
    
    def starred_todos
      todos.select { |todo| todo.starred? }
    end
    
    def make
      FileUtils.mkdir_p(path)
      FileUtils.mkdir_p(shared_path)
      
      unless File.exists?(shared_link_path)
        FileUtils.ln_s(shared_path, shared_link_path)
      end
      
      write_todos
    end
    
    def write_todos
      File.open(todo_path, 'w') do |f|
        YAML.dump(todos.map(&:to_hash), f)
      end
    end
  end
end