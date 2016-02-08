require 'eventmachine'
require 'em-http'
require 'fiber'
 
do_request_fiber = Fiber.new do
  puts "Setting up HTTP request #1"
 
  f = Fiber.current
  http = EventMachine::HttpRequest.new('http://www.baidu.com/').get :timeout => 10
 
  http.callback { EM.stop; puts '11111'; f.resume(http) }
  http.errback { EM.stop; puts '22222'; f.resume(http) }
 
  puts "Fetched page #1: #{Fiber.yield.response_header.status}"
end
 
EventMachine.run do
  puts "33333"
  do_request_fiber.resume
end
