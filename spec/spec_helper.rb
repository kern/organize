require 'bundler/setup'

require 'rspec'
require 'bourne'

require 'organize'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
end