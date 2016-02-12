require 'rubygems'
require 'bundler/setup'

require 'celluloid/autostart'
require 'reel'

Reel::Server::HTTP.supervise("0.0.0.0", 3000) do |connection|
  # Support multiple keep-alive requests per connection
  connection.each_request do |request|
    # WebSocket support
    if request.websocket?
      puts "Client made a WebSocket request to: #{request.url}"
      websocket = request.websocket

      websocket << "Hello everyone out there in WebSocket land"
      websocket.close
    else
      puts "Client requested: #{request.method} #{request.url}"
      request.respond :ok, "Hello, world!"
    end
  end
end

sleep
