$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'grape'
require 'server'
require 'active_record'
require 'models/post'

config = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(config)

use ::Rack::ShowExceptions

run Server::API
