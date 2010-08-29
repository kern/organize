require 'bundler/setup'

require 'rspec'
require 'not_a_mock'
require 'fakefs/spec_helpers'

require 'organize'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.mock_with NotAMock::RspecMockFrameworkAdapter
end