require "uri"

module UriParser
  extend self

  VIEW_ROOT = File.expand_path "./views"

  def parse_request(request)
    request_uri = request.split(" ")[1]

    if request_uri != "/"
      path = URI.unescape(URI(request_uri).path) + ".html.erb"
    else
      path = "/welcome.html.erb"
    end

    File.join(VIEW_ROOT, path)
  end

end