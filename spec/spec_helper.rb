require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'

require 'fabrication'
require 'hyperclient'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
end

require 'capybara/rspec'
Capybara.configure do |config|
  config.app = SlackBotServer::App.new
  config.server_port = 9293
end

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].each do |file|
  require file
end