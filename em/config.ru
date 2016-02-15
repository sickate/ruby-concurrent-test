$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'cramp'

require 'yaml'
require 'active_record'
require 'models/post'

require 'hello'
require 'sleep'
require 'sql_sleep'
require 'sql_insert'
require 'sql_select'
require 'http_router'

config = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(config)

routes = HttpRouter.new do
  # test CPU heavy action
  add('/hello').to(WelcomeController)
  add('/sleep').to(Sleep)
  add('/sql_insert').to(SqlInsert)
  add('/sql_sleep').to(SqlSleep)
  add('/sql_select').to(SqlSelect)
end

Rack::Handler::Thin.run routes, :Port => 3000



# bundle exec thin -V -R examples/hello_world.ru start
# bundle exec rainbows -E deployment -c examples/rainbows.conf examples/hello_world.ru
