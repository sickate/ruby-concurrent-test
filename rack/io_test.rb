require 'rack/request'
require 'rack/response'
require 'httparty'

class IoTest
  LambdaLobster = lambda { |env|
    content = ["<title>Lobstericious!</title>",
               "<pre>", lobster, "</pre>",
               "<a href='#{href}'>flip!</a>"]
    length = content.inject(0) { |a,e| a+e.size }.to_s
    [200, {CONTENT_TYPE => "text/html", CONTENT_LENGTH => length}, content]
  }

  def call(env)
    #req = Rack::Request.new(env)

    # test with sql
    #sql_test

    # test with sleep
    sleep_test 0.01

    # test with external website
    #url_test
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

  def sleep_test seconds=1
    sleep(seconds)

    res = Rack::Response.new
    res.write "<title>KKKKK!</title>"
    res.write "<h1>"
    res.write "I slept #{seconds} seconds!"
    res.write "</h1>"
    res.finish
  end

  # Yeah Baidu will block you after a while
  def url_test
    response = HTTParty.get('http://www.baidu.com')
    res = Rack::Response.new
    res.write response.body
    res.finish
  end

end
