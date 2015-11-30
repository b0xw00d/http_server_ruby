require "rake"
require "rerun"

task default: %w[server]

task :server do
  puts "\e[34m\nrunning Chasey Server at localhost:2000...\n\e[0m"
  sh "rerun server/http_server.rb"
end