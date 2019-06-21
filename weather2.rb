require "http"
require "tty-prompt"

system "clear"
puts "Welcome to the Weathr app!"
prompt = TTY::Prompt.new
city = prompt.select("Choose a city:", ["Chicago", "Orlando", "Sacramento"])

response = HTTP.get("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial&APPID=_____")
weather_data = response.parse

temperature = weather_data["main"]["temp"]
description = weather_data["weather"][0]["description"]

puts "Today in #{city} it is #{temperature} degrees outside with #{description}."
