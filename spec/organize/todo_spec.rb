require 'spec_helper'

describe Organize::TODO do
  let(:todo) { Organize::TODO.new 'Foo' }
  subject { todo }
  
  it 'should have a name' do
    subject.name == 'Foo'
  end
  
  context 'when the todo name is changed' do
    it 'should be modified' do
      lambda {
        subject.name = 'Bar'
      }.should change(subject, :name).from('Foo').to('Bar')
    end
  end
  
  describe 'status' do
    context 'when complete' do
      subject { Organize::TODO.new 'Foo', :status => :complete }
      
      it { should be_complete }
      it { should_not be_incomplete }
      it { should_not be_starred }
    end
    
    context 'when incomplete' do
      it { should_not be_complete }
      it { should be_incomplete }
      it { should_not be_starred }
    end
    
    context 'when starred' do
      subject { Organize::TODO.new 'Foo', :status => :starred }
      
      it { should_not be_complete }
      it { should be_incomplete }
      it { should be_starred }
    end
    
    it 'should be mutable' do
      lambda {
        subject.status = :complete
      }.should change(subject, :status).from(:incomplete).to(:complete)
    end
  end
  
  describe 'tags' do
    context 'when created without tags' do
      its(:tags) { should be_empty }
    end
    
    context 'when created with tags' do
      subject { Organize::TODO.new 'Foo', :tags => ['test', 'tag'] }
      
      it 'should store those tags' do
        subject.tags.should include('test', 'tag')
      end
    end
    
    it 'should be mutable' do
      lambda {
        subject.tags = ['test']
      }.should change(subject, :tags).from([]).to(['test'])
    end
  end
  
  describe '#to_hash' do
    subject { todo.to_hash }
    
    it 'should have the correct name' do
      subject[:name].should == 'Foo'
    end
    
    it 'should have the correct status' do
      [:complete, :incomplete, :starred].each do |status|
        todo.status = status
        subject = todo.to_hash # Fake the regenration of the #subject
        
        subject[:status].should == status
      end
    end
    
    context 'when the todo has no tags' do
      it 'should have no tags in the hash' do
        subject[:tags].should be_empty
      end
    end
    
    context 'when the todo has tags' do
      before { todo.tags = ['test'] }
      
      it 'should include those tags in the hash' do
        subject[:tags].should include('test')
      end
    end
  end
end