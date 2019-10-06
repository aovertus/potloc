require 'faye/websocket'
require 'eventmachine'
require 'json'

namespace :listener do
  task :start => :environment do
    EM.run {
      ws = Faye::WebSocket::Client.new('ws://localhost:8080/')

      ws.on :message do |event|
        data = JSON.parse(event.data)

        Products::CreateService.new(data).process
      end
    }
  end
end
