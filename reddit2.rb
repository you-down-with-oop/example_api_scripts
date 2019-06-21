require "http"
require "tty-prompt"

prompt = TTY::Prompt.new

system "clear"
puts "Welcome to the Reddit app!"
print "Enter a subreddit name: "
subreddit_name = gets.chomp

response = HTTP.get("https://www.reddit.com/r/#{subreddit_name}.json")
posts = response.parse["data"]["children"]

index = 0
choices = {}
posts.length.times do
  post = posts[index]
  choices[post["data"]["title"]] = index
  index = index + 1
end

input_index = prompt.select("Select a post to see the comments", choices)

post = posts[input_index]
response = HTTP.get("https://www.reddit.com#{post["data"]["permalink"]}.json")
comments = response.parse[1]["data"]["children"]
index = 0
comments.length.times do
  comment = comments[index]
  author = comment["data"]["author"]
  body = comment["data"]["body"]
  puts "Author: #{author}"
  puts body
  puts
  index = index + 1
end
