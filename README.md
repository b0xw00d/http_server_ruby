# I built a simple http server from scratch in Ruby! Yay!

##Instructions: (don't include the $ signs)

Clone this repository then navigate to that directory in your terminal:
```bash
  $ git clone https://github.com/b0xw00d/http_server_ruby.git
  $ cd http_server_ruby
```

Run the server:
```bash
  $ rake chasey_server
```

Visit in your browser at localhost:2000, or view page contents from the command line with:
```bash
  $ curl -v http://localhost:2000/
```

To add your own views save an html.erb file in the 'views' directory of this repo, then visit it with the curl command:
```bash
  $ curl -v http://localhost:2000/name_of_your_view
```