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

  def set_path(request)
    UriParser.parse_request_path(request)
  end

  def set_params(request)
    UriParser.parse_params(request)
  end

  def build_response(path)
    if File.exist?(path) && !File.directory?(path)
      ERB.new(File.open(path).read, 0, '>')
    else
      "<h1><span style='color:red'>Error!</span> 404: not found</h1>"
    end
  end

  def set_status(response)
    response.is_a?(ERB) ? 200 : 404
  end

  def send_response(status, response)
    if status == 200
      ServerSetup.response_headers(status, response.result(binding))
    else
      ServerSetup.response_headers(status, response)
    end
  end

  def control_variables(params)
    @first = params.fetch("first", ["good"])[0]
    @last = params.fetch("last", ["friend"])[0]
  end

  def run
    loop do
      socket = server.accept
      request = socket.gets.chomp

      path = set_path(request)
      params = set_params(request)

      control_variables(params)

      response = build_response(path)
      status = set_status(response)

      socket.puts send_response(status, response)
      socket.close
    end
  end

end

chasey_server = ChaseyServer.new(2000)
chasey_server.run