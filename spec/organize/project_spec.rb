require 'spec_helper'

describe Organize::Project do
  let(:project) { Organize::Project.new 'Foo' }
  subject { project }
  
  it 'should have a name' do
    subject.name.should == 'Foo'
  end
  
  context 'when created without a prefix' do
    its(:prefix) { should == '~/Projects' }
  end
  
  context 'when created without a shared prefix' do
    its(:shared_prefix) { should == '~/Dropbox' }
  end
  
  context 'when created with a prefix' do
    subject { Organize::Project.new 'Foo', :prefix => '~/Prefix' }
    
    it 'should use that prefix instead of the default one' do
      subject.prefix.should == '~/Prefix'
    end
  end
  
  context 'when created with a shared prefix' do
    subject { Organize::Project.new 'Foo', :shared_prefix => '~/Shared' }
    
    it 'should use that prefix instead of the default one' do
      subject.shared_prefix.should == '~/Shared'
    end
  end
  
  describe '#path' do
    before do
      project.track_methods :prefix, :name
      subject # Run the subject immediately
    end
    
    subject { project.path }
    
    it 'should combine the prefix and name' do
      project.should have_received(:prefix)
      project.should have_received(:name)
      should == '~/Projects/Foo'
    end
  end
  
  describe '#archive_path' do
    before do
      project.track_methods :path
      subject # Run the subject immediately
    end
    
    subject { project.archive_path }
    
    it 'should tack on Archive to the end of the path' do
      project.should have_received(:path)
      should == '~/Projects/Foo/Archive'
    end
  end
  
  describe '#shared_path' do
    before do
      project.track_methods :shared_prefix, :name
      subject # Run the subject immediately
    end
    
    subject { project.shared_path }
    
    it 'should tack on the name to the end of the shared path' do
      project.should have_received(:shared_prefix)
      project.should have_received(:name)
      should == '~/Dropbox/Foo'
    end
  end
  
  describe '#shared_link_path' do
    before do
      project.track_methods :path
      subject # Run the subject immediately
    end
    
    subject { project.shared_link_path }
    
    it 'should tack on Shared to the end of the path' do
      project.should have_received(:path)
      should == '~/Projects/Foo/Shared'
    end
  end
  
  describe '#project_archive_path' do
    before do
      project.track_methods :prefix
      subject # Run the subject immediately
    end
    
    subject { project.project_archive_path }
    
    it 'should tack on Archive to the end of the prefix' do
      project.should have_received(:prefix)
      should == '~/Projects/Archive'
    end
  end
  
  describe '#create' do
    subject { project.create }
    
    context 'when the prefix does not exist' do
      before do
        FileUtils.rm_rf(project.prefix)
        subject # Run the subject immediately
      end
      
      it 'should be created' do
        File.directory?(project.prefix).should be_true
      end
      
      it 'should create the project directory' do
        File.directory?(project.path).should be_true
      end
    end
    
    context 'when the prefix does exist' do
      let(:other_project_path) { File.join(project.prefix, 'Bar') }
      
      before do
        FileUtils.rm_rf(project.prefix)
        FileUtils.mkdir_p(other_project_path)
        subject # Run the subject immediately
      end
      
      it 'should not delete the other files/directories in the prefix' do
        File.directory?(other_project_path).should be_true
      end
      
      it 'should only create the project directory' do
        File.directory?(project.path).should be_true
      end
    end
    
    context 'when the shared prefix does not exist' do
      before do
        FileUtils.rm_rf(project.shared_prefix)
        subject # Run the subject immediately
      end
      
      it 'should be created' do
        File.directory?(project.shared_prefix).should be_true
      end
      
      it 'should create the project directory' do
        File.directory?(project.shared_path).should be_true
      end
    end
    
    context 'when the shared prefix does exist' do
      let(:other_shared_path) { File.join(project.shared_prefix, 'Bar') }
      
      before do
        FileUtils.rm_rf(project.shared_prefix)
        FileUtils.mkdir_p(other_shared_path)
        subject # Run the subject immediately
      end
      
      it 'should not delete the other files/directories in the shared prefix' do
        File.directory?(other_shared_path).should be_true
      end
      
      it 'should only create the project shared directory' do
        File.directory?(project.shared_path).should be_true
      end
    end
  end
  # TODO: Make the shared and archive path automatically deleted.
  
  describe '#archive' do
    subject { project.archive }
    before { subject }
    
    it 'should move the project to the project archive folder' do
      # TODO: Implement me!
    end
  end
end