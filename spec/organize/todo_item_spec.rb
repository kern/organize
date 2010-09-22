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
  
  context 'when completeness is false' do
    it { should be_incomplete }
    it { should_not be_complete }
  end
  
  context 'when completeness is true' do
    subject { Organize::TODOItem.new 'Test item', :complete => true }
    
    it { should_not be_incomplete }
    it { should be_complete }
  end
end