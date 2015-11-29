
module ServerSetup
  extend self

  STATUS_MESSAGES = {
    200 => "OK",
    404 => "NOT FOUND"
  }

  def response_headers(status_code, response)
    ["HTTP/1.1 #{status_code} #{STATUS_MESSAGES[status_code]}",
     "Date: #{DateTime.now}",
     "Server: Ruby/2.2.2 (Unix) (El-Capitan/OSX)",
     "Content-Type: text/html; charset=UTF-8",
     "Content-Length: #{response.length}",
     "Conection: close",
     "",
     response]
  end

end
