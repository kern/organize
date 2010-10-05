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
    def new(name)
      config = YAML::load_file '~/.organize'
      project = Project.new name, :prefix => config['prefix'], :shared_prefix => config['shared_prefix']
      project.create
      
      puts "#{name} created! :D"
    end
  end
end