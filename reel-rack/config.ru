$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'sql_test'
require 'url_test'
require 'sleep_test'
require 'fusion_test'
require 'yaml'
require 'active_record'
require 'celluloid/current'
require 'reel'

config = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(config)

use ::Rack::ShowExceptions

app = Rack::Builder.app do
#  map '/db' do
    #run SqlTest.new
  #end

  #map '/url' do
    #run UrlTest.new
  #end

  #map '/sleep' do
    #run SleepTest.new
  #end

  #map '/fusion' do
    #run FusionTest.new
#  end

  map '/hello' do
    run Proc.new {|env| [200, {"Content-Type" => "text/html"}, "Hello Rack!"]}
  end
end

run app
