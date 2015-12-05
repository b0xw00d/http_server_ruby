require 'socket'
require 'date'
require 'erb'
require_relative 'server_setup'
require_relative 'uri_parser'

class ChaseyServer

  ERROR_RESPONSE = "<h1><span style='color:red'>Error!</span> 404: page not found</h1>"

  attr_reader :server
  def initialize(port)
    @server = TCPServer.new("localhost", port)
  end

  def build_response(path)
    if File.exist?(path) && !File.directory?(path)
      ERB.new(File.open(path).read, 0, '>')
    else
      ERROR_RESPONSE
    end
  end

  def set_status(response)
    response.is_a?(ERB) ? 200 : 404
  end

  def set_path(request)
    UriParser.parse_request_path(request)
  end

  def set_params(request)
    UriParser.parse_params(request)
  end

  def run
    loop do
      socket = server.accept
      request = socket.gets.chomp
      path = set_path(request)
      params = set_params(request)
      @first = params.fetch("first", ["good"])[0]
      @last = params.fetch("last", ["friend"])[0]

      response = build_response(path)
      status_code = set_status(response)

      socket.puts ServerSetup.response_headers(status_code, response.result(binding))
      socket.close
    end
  end

end

chasey_server = ChaseyServer.new(2000)
chasey_server.run