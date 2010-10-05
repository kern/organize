require 'spec_helper'

describe Organize::Runner do
  let(:runner) { Organize::Runner.new }
  subject { runner }
  
  before do
    FileUtils.rm_rf '~'
    
    ['~/Desktop', '~/Documents', '~/Movies', '~/Music', '~/Pictures',  '~/Public', '~/Sites'].each do |directory|
      FileUtils.mkdir_p directory
    end
  end
  
  # TODO: Make these tests not suck.
  describe '#install' do
    subject { runner.install }
    before { subject }
    
    it 'should create the necessary directories' do
      ['~', '~/Projects', '~/Dropbox', '~/Projects/Archive', '~/Projects/Other'].each do |directory|
        File.directory?(directory).should be_true
      end
    end
    
    it 'should symlink the Other directories' do
      ['Documents', 'Movies', 'Music', 'Pictures',  'Public', 'Sites'].each do |directory|
        File.symlink?(File.join('~/Projects/Other', directory)).should be_true
      end
    end
    
    it 'should write to the .organize file correctly' do
      YAML::load_file('~/.organize').should == {
        'prefix' => '~/Projects',
        'shared_prefix' => '~/Dropbox'
      }
    end
  end
  
  describe '#create' do
    subject { runner.create 'Foo' }
    
    before do
      runner.install
      subject
    end
    
    it 'should create the new project' do
      File.directory?('~/Projects/Foo').should be_true
    end
  end
  
  describe '#prefix' do
    subject { runner.prefix }
    before { runner.install }
    
    it 'should return the prefix' do
      stdout = capture(:stdout) { subject }
      stdout.should == '~/Projects'
    end
  end
end