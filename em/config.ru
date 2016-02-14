$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'cramp'

require 'yaml'
require 'active_record'

require 'hello'
require 'sleep'
require 'sql_sleep'
require 'sql_insert'
require 'sql_select'

config = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(config)



app = Rack::Builder.app do
  # test CPU heavy action
  map '/hello' do
    run WelcomeController
  end

  # test IO heavy action
  map '/sleep' do
    run Sleep.new
  end
  map '/sql_sleep' do
    run SqlSleep.new
  end
  map '/sql_insert' do
    run SqlInsert.new
  end
  map '/sql_select' do
    run SqlSelect.new
  end
end



# bundle exec thin -V -R examples/hello_world.ru start
# bundle exec rainbows -E deployment -c examples/rainbows.conf examples/hello_world.ru
