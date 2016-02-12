require 'rack/request'
require 'rack/response'
require 'httparty'

class SqlTest
  LambdaLobster = lambda { |env|
    content = ["<title>Lobstericious!</title>",
               "<pre>", lobster, "</pre>",
               "<a href='#{href}'>flip!</a>"]
    length = content.inject(0) { |a,e| a+e.size }.to_s
    [200, {CONTENT_TYPE => "text/html", CONTENT_LENGTH => length}, content]
  }

  def call(env)
    sql_test 0.1
  end

  # depends on how many connections your pg allows at once
  def sql_test sec=1
    sql = "select pg_sleep(#{sec})"
    ActiveRecord::Base.connection.execute(sql)

    res = Rack::Response.new
    res.write "<title>KKKKK!</title>"
    res.write "<h1>"
    res.write "I slept #{sec} seconds!"
    res.write "</h1>"
    res.finish
  end
end
