require 'rack/request'
require 'rack/response'
require 'httparty'

class SleepTest
  def call(env)
    sleep_test 0.1
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
end
