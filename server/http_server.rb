require 'socket'
require 'date'
require 'erb'
require_relative 'server_setup'
require_relative 'uri_parser'

class ChaseyServer

  attr_reader :server
  def initialize(port)
    @server = TCPServer.new("localhost", port)
  end

  def run
    loop do
      socket = server.accept
      request = socket.gets.chomp
      path = UriParser.parse_request_path(request)
      params = UriParser.parse_params(request)
      @first = params.fetch("first", ["good"])[0]
      @last = params.fetch("last", ["friend"])[0]

      if File.exist?(path) && !File.directory?(path)
        response = ERB.new(File.open(path).read, 0, '>')
        status_code = 200
      else
        response = <<-RESPONSE_STRING
          <h1><span style='color:red'>Error!</span> 404: page not found</h1>
        RESPONSE_STRING
        status_code = 404
      end

      socket.puts ServerSetup.response_headers(status_code, response.result(binding))
      socket.close
    end
  end

  def close
    server.close
  end

end

chasey_server = ChaseyServer.new(2000)
chasey_server.run