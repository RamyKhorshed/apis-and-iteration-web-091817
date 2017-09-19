require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  output = []
  filmArray = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  results = character_hash["results"]
    results.each do |person|
      if person["name"].downcase == character
        output = person["films"]
      end
    end
    output.each do |link|
      moviedata = RestClient.get(link)
      moviedata_hash = JSON.parse(moviedata)
      filmArray << moviedata_hash
    end
  #  if results[:name] == "character"
  #    puts results[:films]
  #  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  return filmArray
end



def parse_character_movies(films_hash)
  count = 0
  films_hash.each do |movie|
    count += 1
    puts "#{count} #{movie["title"]}"
  end
  # some iteration magic and puts out the movies in a nice list
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
