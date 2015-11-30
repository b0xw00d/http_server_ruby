require 'socket'
require 'date'
require_relative 'server_setup'
require_relative 'uri_parser'

class ChaseyServer

  attr_reader :server
  def initialize
    @server = TCPServer.new("localhost", 2000)
  end

  def run
    loop do
      socket = server.accept
      request = socket.gets.chomp
      path = UriParser.parse_request(request)

      if File.exist?(path) && !File.directory?(path)
        response = File.open(path).read
        status_code = 200
      else
        response = <<-RESPONSE_STRING
          <h1><span style='color:red'>Error!</span> 404: page not found</h1>"
        RESPONSE_STRING
        status_code = 404
      end

      socket.puts ServerSetup.response_headers(status_code, response)
      socket.close
    end
  end

end

chasey_server = ChaseyServer.new
chasey_server.run