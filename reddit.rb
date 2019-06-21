require "http"

system "clear"
puts "Welcome to the Reddit app!"
print "Enter a subreddit name: "
subreddit_name = gets.chomp

response = HTTP.get("https://www.reddit.com/r/#{subreddit_name}.json")
posts = response.parse["data"]["children"]

index = 0
posts.length.times do
  post = posts[index]
  puts "#{index}. #{post["data"]["title"]}"
  index = index + 1
end

print "Enter a number to see the comments: "
input_index = gets.chomp.to_i

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
