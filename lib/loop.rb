require 'eventmachine'
require 'evma_httpserver'

class Handler < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new(self)
    resp.status = 200
    resp.content = "This content is being served by EventMachine::HttpServer!"
    resp.send_response
  end
end

EventMachine::run {
  host, port = "0.0.0.0", ENV['PORT']
  puts "Starting on #{host}:#{port}..."
  EventMachine::start_server(host, port, Handler)
}