require 'spec_helper'

describe Organize::TODOItem do
  let(:item) { Organize::TODOItem.new 'Test item' }
  subject { item }
  
  it 'should have a name' do
    subject.name == 'Test item'
  end
  
  context 'when the item name is changed' do
    it 'should be modified' do
      lambda {
        subject.name = 'Another item'
      }.should change(subject, :name).from('Test item').to('Another item')
    end
  end
  
  describe 'status' do
    context 'when complete' do
      subject { Organize::TODOItem.new 'Test item', :status => :complete }
      
      it { should be_complete }
      it { should_not be_incomplete }
    end
    
    context 'when incomplete' do
      it { should_not be_complete }
      it { should be_incomplete }
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
      subject { Organize::TODOItem.new 'Foo', :tags => ['test', 'tag'] }
      
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
    subject { item.to_hash }
    
    it 'should have a key of the name of the item' do
      should include('Test item')
    end
    
    context 'when the item is complete' do
      before { item.status = :complete }
      
      it 'should have a status of complete' do
        subject['Test item'][:status].should == :complete
      end
    end
    
    context 'when the item is incomplete' do
      it 'should have a status of incomplete' do
        subject['Test item'][:status].should == :incomplete
      end
    end
    
    context 'when the item has no tags' do
      it 'should have no tags in the hash' do
        subject['Test item'][:tags].should be_empty
      end
    end
    
    context 'when the item has tags' do
      before { item.tags = ['test'] }
      
      it 'should include those tags in the hash' do
        subject['Test item'][:tags].should include('test')
      end
    end
  end
end