require 'eventmachine'
require 'uuid'

# FIXME: this stupid piece of shit can only server one client at a time

class PushServer < EM::Connection
  attr_accessor :uuid

  @@clients = []

  def self.clients
    @@clients
  end

  #def self.uuid_generator
    #@@uuid_generator ||= UUID.new
  #end

  def broadcast msg, slugs
    @@clients.each do |client|
      client.send_data msg
    end
  end

  #def initialize
    #@uuid = PushServer.uuid_generator.generate
    #super
  #end

  def post_init
    @@clients << self
    puts "#{self} connected"
  end

  def receive_data data
    send_data "HTTP/1.1 200 OK
Server: Ziltag Push Server
Content-Type: text/event-stream
Connection: keep-alive
Access-Control-Allow-Origin: *\n\n"
  end

  def unbind
    @@clients.delete(self)
    puts "#{self} disconnected"
  end
end

EventMachine.run do
  EventMachine.add_periodic_timer(1) do
    PushServer.clients.each do |client|
      #client.send_data "event: time\ndata: #{Time.now}\n\nuuid: #{client.uuid}\n"
      client.send_data "event: time\ndata: #{Time.now}\n\n"
    end
  end
  EventMachine.start_server '0.0.0.0', 3000, PushServer
end
