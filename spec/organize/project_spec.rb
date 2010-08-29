require 'spec_helper'

describe Organize::Project do
  let(:project) { Organize::Project.new 'Foo' }
  
  it 'should have a name' do
    project.name.should == 'Foo'
  end
end