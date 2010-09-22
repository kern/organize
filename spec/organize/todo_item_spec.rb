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
    context 'when complete is false' do
      it { should be_incomplete }
      it { should_not be_complete }
    end
  
    context 'when complete is true' do
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
end