require 'rack/request'
require 'rack/response'
require 'httparty'

class UrlTest
  def call(env)
    # test with external website
    url_test
  end

  # Yeah Baidu will block you after a while
  def url_test
    response = HTTParty.get('http://www.baidu.com')
    res = Rack::Response.new
    res.write response.body
    res.finish
  end

end
