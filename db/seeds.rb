require 'uri'
require 'net/http'
require 'json'

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMTY5YTUwMWM0NjMwYjJlMzJiYzA2YTE3NjlhYjc2MCIsInN1YiI6IjY1YjYyYjYyMWM2MzViMDE3YjE0N2VkNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bJ2iGOby18NIM8fQbStirec2-ZIPVtAzw1gQ0V_qm38'

response = http.request(request)

if response.code.to_i == 200
  result = JSON.parse(response.body)

  movies = result['results']

  movies.each do |movie|
    base_url = 'https://image.tmdb.org/t/p/'
    size = 'w500'
    poster_path = movie['poster_path']
    poster_url = "#{base_url}#{size}#{poster_path}" unless poster_path.nil?

    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: poster_url
    )
  end
  puts "Movies added!"
else
  puts "Failed to fetch movies. HTTP Status: #{response.code}"
end
