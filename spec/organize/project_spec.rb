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
  
  context 'when created without TODOs' do
    its(:todos) { should be_empty }
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
  
  context 'when created with a TODO' do
    let(:todo) { Organize::TODO.new 'Bar' }
    subject { Organize::Project.new 'Foo', :todos => [todo] }
    
    it 'should store the TODOs' do
      subject.todos.should include(todo)
    end
  end
  
  describe '#path' do
    before do
      project.track_methods :prefix, :name
      subject
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
      subject
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
      subject
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
      subject
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
      subject
    end
    
    subject { project.project_archive_path }
    
    it 'should tack on Archive to the end of the prefix' do
      project.should have_received(:prefix)
      should == '~/Projects/Archive'
    end
  end
  
  describe 'TODOs' do
    let(:complete_todo) { Organize::TODO.new 'Bar', :status => :complete }
    let(:incomplete_todo) { Organize::TODO.new 'Bar', :status => :incomplete }
    let(:starred_todo) { Organize::TODO.new 'Bar', :status => :starred }
    
    let(:project) do
      Organize::Project.new 'Foo', :todos => [
        complete_todo,
        incomplete_todo,
        starred_todo
      ]
    end
    
    subject { project }
    
    it 'should be mutable' do
      lambda {
        subject.todos = [complete_todo]
      }.should change(subject, :todos).to([complete_todo])
    end
    
    describe '#todo_path' do
      before do
        project.track_methods :shared_path
        subject
      end
      
      subject { project.todo_path }
      
      it 'should tack on TODO to the end of the shared path' do
        project.should have_received(:shared_path)
        should == '~/Dropbox/Foo/TODO'
      end
    end
    
    describe '#complete_todos' do
      subject { project.complete_todos }
      
      it 'should return the complete TODOs' do
        should include(complete_todo)
      end
    end
    
    describe '#incomplete_todos' do
      subject { project.incomplete_todos }
      
      it 'should return the incomplete TODOs' do
        should include(incomplete_todo, starred_todo)
      end
    end
    
    describe '#starred_todos' do
      subject { project.starred_todos }
      
      it 'should return the starred TODOs' do
        should include(starred_todo)
      end
    end
  end
  
  describe '#make' do
    before do
      FileUtils.rm_rf(project.prefix)
      FileUtils.rm_rf(project.shared_prefix)
    end
    
    subject { project.make }
    
    context 'when the prefix does not exist' do
      before { subject }
      
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
        FileUtils.mkdir_p(other_project_path)
        subject
      end
      
      it 'should not delete the other files/directories in the prefix' do
        File.directory?(other_project_path).should be_true
      end
      
      it 'should only create the project directory' do
        File.directory?(project.path).should be_true
      end
    end
    
    context 'when the shared prefix does not exist' do
      before { subject }
      
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
        FileUtils.mkdir_p(other_shared_path)
        subject
      end
      
      it 'should not delete the other files/directories in the shared prefix' do
        File.directory?(other_shared_path).should be_true
      end
      
      it 'should only create the project shared directory' do
        File.directory?(project.shared_path).should be_true
      end
    end
    
    context 'when the shared link does not exist' do
      before do
        FileUtils.mkdir_p(project.path)
        subject
      end
      
      it 'should be created and symlinked to the shared path' do
        File.symlink?(project.shared_link_path).should be_true
        File.readlink(project.shared_link_path).should == project.shared_path
      end
    end
    
    context 'when the shared link already exists' do
      before do
        FileUtils.mkdir_p(project.shared_link_path)
        subject
      end
      
      it 'should be left alone' do
        File.symlink?(project.shared_link_path).should be_false
      end
    end
    
    it 'should write the TODOs to the TODO path' do
      project.track_methods :write_todos
      subject
      project.should have_received(:write_todos)
    end
  end
  
  describe '#write_todos' do
    let(:todo) { Organize::TODO.new 'Bar' }
    let(:project) { Organize::Project.new 'Foo', :todos => [todo] }
    subject { project.write_todos }
    before { subject }
    
    it 'should write the YAMLified TODOs to the TODO path' do
      YAML.load_file(project.todo_path).should == [{'name' => 'Bar', 'tags' => [], 'status' => 'incomplete'}]
    end
  end
  
  describe '#load_todos' do
    # TODO: Implement me!
  end
end