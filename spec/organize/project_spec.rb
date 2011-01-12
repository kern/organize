require 'spec_helper'

describe Organize::Project do
  before do
    @project = Organize::Project.new 'Foo'
  end
  
  it "should have a #name" do
    @project.name.should == 'Foo'
  end
  
  describe "#path" do
    it "should concatenate the prefix and #name" do
      @project.path.should == File.expand_path('~/Projects/Foo')
    end
  end
  
  describe "#shared_path" do
    it "should concatenate the shared prefix #name" do
      @project.shared_path.should == File.expand_path('~/Dropbox/Foo')
    end
  end
  
  describe "#shared_link_path" do
    it "should concatenate the #path and Shared" do
      @project.shared_link_path.should == File.expand_path('~/Projects/Foo/Shared')
    end
  end
  
  describe "#project_archive_path" do
    it "should tack on Archive to the end of the prefix" do
      @project.project_archive_path.should == File.expand_path('~/Projects/Archive')
    end
  end
  
  describe "#create" do
    before do
      FileUtils.rm_rf File.expand_path('~')
      @project.create
    end
    
    it "should create the project directory" do
      File.directory?(@project.path).should be_true
    end
    
    it "should create the shared project directory" do
      File.directory?(@project.shared_path).should be_true
    end
    
    it "should create the project archive directory" do
      File.directory?(@project.project_archive_path).should be_true
    end
  end
end