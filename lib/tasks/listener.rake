require 'faye/websocket'
require 'eventmachine'
require 'json'

namespace :listener do
  task :start => :environment do
    EM.run {
      ws = Faye::WebSocket::Client.new('ws://localhost:8090/')

      ws.on :message do |event|
        data = JSON.parse(event.data)
        puts "Receiving #{data}"
        Products::StreamingService.new(data).process
      end
    }
  end
end
