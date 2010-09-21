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
  
  context 'when created with a prefix' do
    subject { Organize::Project.new 'Foo', '~/Prefix' }
    it 'should use that prefix instead of the default one' do
      subject.prefix.should == '~/Prefix'
    end
  end
  
  describe '#path' do
    before { project.track_methods :prefix, :name }
    subject { project.path }
    
    it 'should combine the prefix and name' do
      subject.should have_received :prefix
      subject.should have_received :name
      subject.should == '~/Projects/Foo'
    end
  end
end