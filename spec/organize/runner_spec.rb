require 'spec_helper'

describe Organize::Runner do
  let(:runner) { Organize::Runner }
  subject { runner }
  
  before do
    FileUtils.rm_rf '~'
    
    %w{Desktop Documents Movies Music Pictures Public Sites}.each do |directory|
      directory = File.expand_path("~/#{directory}")
      FileUtils.mkdir_p(directory)
    end
  end
  
  describe '#install' do
    before { runner.dispatch(%w{install}) }
    
    it 'should create the prefixes' do
      %w{Projects Dropbox}.each do |directory|
        directory = File.expand_path("~/#{directory}")
        File.directory?(directory).should be_true
      end
    end
    
    it 'should create the Inbox and Other projects' do
      %w{Inbox Other}.each do |directory|
        directory = File.expand_path("~/Projects/#{directory}")
        File.directory?(directory).should be_true
      end
    end
    
    it 'should symlink the Other directories' do
      %w{Documents Movies Music Pictures Public Sites}.each do |directory|
        directory = File.expand_path("~/Projects/Other/#{directory}")
        File.symlink?(directory).should be_true
      end
    end
  end
  
  describe '#create' do
    before do
      runner.dispatch(%w{install})
      runner.dispatch(%w{create Foo})
    end
    
    it 'should create the new project' do
      File.directory?('~/Projects/Foo').should be_true
    end
  end
end