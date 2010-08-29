require 'spec_helper'

describe Organize::Runner do
  
  include FakeFS::SpecHelpers
  
  before do
    Organize::Runner.build
    @parser = Organize::Runner.optitron_parser
  end
  
  it 'should work'
end