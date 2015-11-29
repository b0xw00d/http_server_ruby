require 'socket'
require 'date'
require_relative 'server_setup'

class ChaseyServer
  PATH_ROOT = "./views"
  WELCOME = File.expand_path PATH_ROOT + "/welcome.html.erb"
  PROFILE = File.expand_path PATH_ROOT + "/profile.html.erb"

  attr_reader :server, :welcome, :profile
  def initialize
    @server = TCPServer.new("localhost", 2000)
    @welcome = File.open(WELCOME).read
    @profile = File.open(PROFILE).read
  end

  def runner
    loop do
      socket = server.accept
      request = socket.gets.chomp

      case request
      when "GET /welcome HTTP/1.1"
        response = welcome
        status_code = 200
      when "GET /profile HTTP/1.1"
        response = profile
        status_code = 200
      else
        response = <<-RESPONSE
          <h1><span style='color:red'>Error!</span> 404: page not found</h1>"
        RESPONSE
        status_code = 404
      end

      socket.puts ServerSetup.response_headers(status_code, response)
      socket.close
    end
  end

end

chasey_server = ChaseyServer.new
chasey_server.runner