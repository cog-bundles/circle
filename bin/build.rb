#!/usr/bin/ruby
require "net/http"
require "json"
require_relative "../lib/circle_url"

project = ARGV[0]
branch = ARGV[1]

if project && branch
  url = CircleUrl.new(project).build_branch(branch)
  request = Net::HTTP.post_form(url, [])
  body = JSON.parse(request.body)
  if body["message"]
    puts body["message"]
  else
    if request.code == "201"
      puts "Started #{branch}"
    end
  end
else
  puts "You must provide a project name and branch name"
end
