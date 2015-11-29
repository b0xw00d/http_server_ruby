
# module UriParser
#   extend self

#   def parse_request(request)
#     request_uri  = request.split(" ")[1]
#     path = URI.unescape(URI(request_uri).path)

#     File.join(PATH_ROOT, path)
#   end

# end