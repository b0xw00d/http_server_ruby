require "uri"
require "cgi"

module UriParser
  extend self

  VIEW_ROOT = File.expand_path "./views"

  def parse_request_path(request)
    request_uri = request.split(" ")[1]
    if request_uri != "/"
      path = URI.unescape(URI(request_uri).path) + ".html.erb"
    else
      path = "/welcome.html.erb"
    end
    File.join(VIEW_ROOT, path)
  end

  def parse_params(request)
    request_uri = request.split(" ")[1]
    query = request_uri.match(/[?](.+)/)
    query != nil ? CGI::parse(query[1]) : {}
  end

end