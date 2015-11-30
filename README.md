# I built a simple http server from scratch in Ruby! Yay!

##Instructions:

+Clone this repository then navigate to that directory (don't include the $ sign):
```bash
  $ git clone https://github.com/b0xw00d/http_server_ruby.git
  $ cd http_server_ruby
```

+Run the server:
```bash
  $ rake server
```

+Visit in browser or view page contents from the command line with:
```bash
  $ curl -v http://localhost:2000/
```

+To add your own views save and html.erb file in the views directory of this repo then visit with the curl command:
```bash
  $ curl -v http://localhost:2000/name_of_your_view
```