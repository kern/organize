require 'spec_helper'

describe Organize::Project do
  let(:project) { Organize::Project.new 'Foo' }
  subject { project }
  
  it 'should have a name' do
    subject.name.should == 'Foo'
  end
  
  describe '#path' do
    before do
      project.track_methods :name
      subject
    end
    
    subject { project.path }
    
    it 'should combine the prefix and name' do
      project.should have_received(:name)
      should == File.expand_path('~/Projects/Foo')
    end
  end
  
  describe '#archive_path' do
    before do
      project.track_methods :path
      subject
    end
    
    subject { project.archive_path }
    
    it 'should tack on Archive to the end of the path' do
      project.should have_received(:path)
      should == File.expand_path('~/Projects/Foo/Archive')
    end
  end
  
  describe '#shared_path' do
    before do
      project.track_methods :name
      subject
    end
    
    subject { project.shared_path }
    
    it 'should tack on the name to the end of the shared path' do
      project.should have_received(:name)
      should == File.expand_path('~/Dropbox/Foo')
    end
  end
  
  describe '#shared_link_path' do
    before do
      project.track_methods :path
      subject
    end
    
    subject { project.shared_link_path }
    
    it 'should tack on Shared to the end of the path' do
      project.should have_received(:path)
      should == File.expand_path('~/Projects/Foo/Shared')
    end
  end
  
  describe '#project_archive_path' do
    subject { project.project_archive_path }
    
    it 'should tack on Archive to the end of the prefix' do
      should == File.expand_path('~/Projects/Archive')
    end
  end
  
  describe '#create' do
    before do
      FileUtils.rm_rf(File.expand_path('~'))
      project.create
    end
    
    it 'should create the project directory' do
      File.directory?(project.path).should be_true
    end
    
    it 'should create the shared project directory' do
      File.directory?(project.shared_path).should be_true
    end
    
    it 'should creat the archive directory' do
      File.directory?(project.archive_path).should be_true
    end
    
    it 'should create the project archive directory' do
      File.directory?(project.project_archive_path).should be_true
    end
  end
end