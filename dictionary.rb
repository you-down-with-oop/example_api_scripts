require "http"

while true
  system "clear"
  puts "Welcome to the Dictionary app!"
  print "Enter a word: "
  input_word = gets.chomp

  response = HTTP.get("http://api.wordnik.com:80/v4/word.json/#{input_word}/definitions?limit=200&includeRelated=true&useCanonical=false&includeTags=false&api_key=______")
  definitions = response.parse

  response = HTTP.get("http://api.wordnik.com:80/v4/word.json/#{input_word}/topExample?useCanonical=false&api_key=______")
  top_example = response.parse

  response = HTTP.get("http://api.wordnik.com:80/v4/word.json/#{input_word}/pronunciations?useCanonical=false&limit=50&api_key=______")
  pronunciations = response.parse

  puts "DEFINITIONS:"
  index = 0
  definitions.length.times do
    definition = definitions[index]
    puts "#{index}. #{definition["text"]}"
    puts
    index += 1
  end

  puts "TOP EXAMPLE"
  puts top_example["text"]
  puts

  puts "PRONUNCIATIONS"
  index = 0
  pronunciations.length.times do
    pronunciation = pronunciations[index]
    puts "#{index + 1}. #{pronunciation["raw"]}"
    index = index + 1
  end

  puts "Enter q to quit, any other key to continue"
  input_option = gets.chomp
  if input_option == "q"
    puts "Thank you, goodbye!"
    break
  end
end
