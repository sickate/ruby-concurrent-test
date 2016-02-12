require 'rack/request'
require 'rack/response'
require 'httparty'

class FusionTest
  attr_accessor :res

  def call(env)
    res = Rack::Response.new
    res.write "<title>Fusion!</title>"

    sleep_test 0.1
    sql_test 0.1

    res.write "<p>"
    res.write "Current thread: #{Thread.current.id}."
    res.write "Current Object id #{self.id}, class: #{self.class}."
    res.write "</p>"
    res.finish
  end

  def sleep_test seconds=1
    sleep(seconds)

    res.write "<p>"
    res.write "Sleep for #{seconds} seconds!"
    res.write "</p>"
  end

  def sql_test sec=1
    sql = "select pg_sleep(#{sec})"
    ActiveRecord::Base.connection.execute(sql)

    res.write "<p>"
    res.write "SQL ran for #{sec} seconds!"
    res.write "</p>"
  end
end
