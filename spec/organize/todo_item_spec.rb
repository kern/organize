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
  
  describe 'completeness' do
    context 'when false' do
      it { should be_incomplete }
      it { should_not be_complete }
    end
  
    context 'when true' do
      subject { Organize::TODOItem.new 'Test item', :complete => true }
    
      it { should_not be_incomplete }
      it { should be_complete }
    end
    
    it 'should be mutable' do
      lambda {
        subject.complete = true
      }.should change(subject, :complete).from(false).to(true)
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
end