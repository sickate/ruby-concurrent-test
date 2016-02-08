$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'io_test'
require 'lobster'
require 'yaml'
require 'active_record'

config = YAML.load_file('config.yml')
ActiveRecord::Base.establish_connection(config)

use ::Rack::ShowExceptions

app = Rack::Builder.app do
  # test CPU heavy action
  map '/zlib' do
    run Lobster.new
  end

  # test IO heavy action
  map '/io' do
    run IoTest.new
  end
end

run app

