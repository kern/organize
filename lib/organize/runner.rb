require 'optitron'
require 'yaml'

module Organize
  class Runner < Optitron::CLI
    desc 'Install organize to your home directory.'
    def install(prefix = '~/Projects', shared_prefix = '~/Dropbox', inbox = '~/Desktop')
      FileUtils.mkdir_p(prefix)
      FileUtils.mkdir_p(File.join(prefix, 'Archive'))
      FileUtils.mkdir_p(shared_prefix)
      FileUtils.mkdir_p(File.join(prefix, 'Other'))
      FileUtils.ln_s(inbox, File.join(prefix, 'Inbox'))
      
      ['Documents', 'Movies', 'Music', 'Pictures',  'Public', 'Sites'].each do |directory|
        FileUtils.ln_s("~/#{directory}", File.join(prefix, 'Other', directory))
      end
      
      config = {
        'prefix' => prefix,
        'shared_prefix' => shared_prefix
      }
      
      File.open('~/.organize', 'w+') { |f| f.write(YAML::dump(config)) }
    end
    
    desc 'Creates a new project.'
    def create(name)
      config = YAML::load_file '~/.organize'
      project = Project.new name, :prefix => config['prefix'], :shared_prefix => config['shared_prefix']
      project.create
    end
    
    desc 'Gets the path for a specific project.'
    def path(name)
      prefix = YAML::load_file('~/.organize')['prefix']
      print File.join(prefix, name)
    end
    
    desc 'Gets the prefix.'
    def prefix
      print YAML::load_file('~/.organize')['prefix']
    end
  end
end