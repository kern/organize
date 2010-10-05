require 'optitron'

module Organize
  class Runner < Optitron::CLI
    desc 'Install stuff'
    def install(prefix = '~/Projects', shared_prefix = '~/Dropbox', inbox = '~/Desktop')
      FileUtils.mkdir_p(prefix)
      FileUtils.mkdir_p(File.join(prefix, 'Archive'))
      FileUtils.mkdir_p(shared_prefix)
      FileUtils.mkdir_p(File.join(prefix, 'Other'))
      FileUtils.ln_s(inbox, File.join(prefix, 'Inbox'))
      
      ['Documents', 'Movies', 'Music', 'Pictures',  'Public', 'Sites'].each do |folder|
        FileUtils.ln_s("~/#{folder}", File.join(prefix, 'Other', folder))
      end
      
      # TODO: Make this method create the .organize file.
    end
  end
end