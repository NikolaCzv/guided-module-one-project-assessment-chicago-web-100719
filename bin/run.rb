require_relative '../config/environment'
require_relative '../lib/song.rb'
require_relative '../lib/artist.rb'
require_relative '../lib/genre.rb'

PROMPT = TTY::Prompt.new

# 🎸🎺🥁🎻🎹🔊

def start_screen

    answer = PROMPT.select("Choose your option?", [ 
        "Search for song",
        "Search for artist",
        "Wild card search (song, artist or genre)",
        "List of songs", 
        "List of artists", 
        "List of genres", 
        "Create and add song",
        "Delete song",
        "Main screen",
        "TOP 3 artists",
        "Most popular genre",
        "Quit"   
    ])

    

if answer == "Wild card search (song, artist or genre)"
        puts `clear`
    search_by
elsif answer == "Search for song"
    puts `clear`
    search_by_word
elsif answer == "Search for artist"
    puts `clear`
    search_by_word_art
elsif 
    answer == "List of songs"
    puts `clear`
    song_list
elsif
    answer == "List of artists"
    puts `clear`
    artist_list
elsif
    answer == "List of genres"
    puts `clear`
    genre_list
elsif
    answer == "Delete song"
    puts `clear`
    delete_song
elsif answer == "Create and add song"
    puts `clear`
    create_song
elsif answer == "Main screen"
    puts `clear`
    main_screen
elsif answer == "Quit"
    puts `clear`                      
    question = PROMPT.yes?('Are you sure you want to exit? ')
     if question == true
        exit
      elsif question ==  false 
           main_screen
       else 
          "Wrong input. Please enter (Y/n)"
      end
       main_screen
elsif answer == "TOP 3 artists"
    puts `clear`
    artist_most_songs
elsif answer == "Most popular genre"
    puts `clear`
    ganre_with_most_songs
else 
    puts `clear`
    puts "✘✘✘ Wrong input. Try again. ✘✘✘"
    start_screen
end


end



def titleize(string)
    string.capitalize!
    words_no_cap = ["and", "or", "the", "over", "to", "the", "a", "but"]
    phrase = string.split(" ").map do |word|
        if words_no_cap.include?(word)
            word
        else
            word.capitalize
        end
    end.join(" ")
    phrase
end

 def search_by_word
     puts "Please enter the name of the song you would like to hear"
     answer = gets.chomp.downcase

     ye = Song.where( "name like ?", "%#{answer}%")
# binding.pry
     if ye != []

        newone = ye.map {|song| song.name}
     puts "List of the songs with the word you are looking for: #{newone.join(', ').titleize}"
    else 
        puts "There are no songs with the word #{answer.titleize} in the title."
    end
    start_screen
end

def search_by_word_art
puts "Please enter the name of an artist you would like to find"
answer = gets.chomp.downcase
puts `clear`

one = Artist.where( "name like ?", "%#{answer}%")

 if one != []
    two = one.map {|artist| artist.name}
    puts "There are artists: #{two.join(', ').titleize}"
 else
    puts "Sorry there are no artist with the word #{answer.titleize} in the name."
 end
 start_screen
end

def search_by
    puts "Please search by song name, artist name or genre"
    answer = gets.chomp.downcase
    if Song.find_by name: answer
        found_song = Song.find_by name: answer
        puts `clear`

        puts " ♫♫♫ The artist who play this song is #{found_song.artist.name.titleize}. ♫♫♫"
        puts " ♫♫♫   The song is on our playlist. Enjoy your song!   ♫♫♫"
        puts "            [music playing in the backround]                    "
    elsif 
        Artist.find_by name: answer
        found_artist = Artist.find_by name: answer
        art = found_artist.songs.map {|song| song.name}.join(', ').titleize
        puts `clear`
        puts "♪♪♪ The artist named #{answer.titleize} is in our file! ♪♪♪"
        puts "♪♪♪ Here is the list of the songs from #{answer.titleize} we have: #{art}. ♪♪♪"
    elsif 
        Genre.find_by name: answer
        found_genre = Genre.find_by name:answer
        gen = found_genre.artists.map {|artist| artist.name}.uniq.join(', ').titleize
        puts `clear`
        puts "♪♪♪ Here is the list of the artists in the #{answer.titleize} we have: #{gen}. ♪♪♪ "
        puts "♪♪♪  The ganre you are looking for is on the file! ♪♪♪"
    else 
        puts "✘✘✘ No such a song, artist or genre. Try to upload song if you want! ✘✘✘"
    end
    start_screen
end

def song_list
    songs_sorted = Song.order(:name)
    puts "♪♪♪ There is #{Song.count} songs in our app! ♪♪♪"
    song_list = songs_sorted.map do |song|
         titleize(song.name)
    end
   song_info =  PROMPT.select("Choose a song for more info!", song_list )
   searched_song = Song.find_by name: song_info.downcase
  
    puts "The artist of the song is #{titleize(searched_song.artist.name)} and the genre is #{titleize(searched_song.genre.name)}. Feel free to add more songs!  ♪♪♪"
     start_screen
end

def artist_list
    sorted_art = Artist.order(:name)
    puts "♪♪♪ There is #{Artist.count} artists in our app! ♪♪♪"
    artist_list = sorted_art.map do |artist|
       titleize(artist.name)
    end
   artist_info = PROMPT.select("Choose an artist info!", artist_list )
   searched_artist = Artist.find_by name: artist_info.downcase
#    binding.pry
        art_song = searched_artist.songs.map {|song| song.name}.join(', ')
   puts "The songs of #{titleize(searched_artist.name)} we have in our app are: #{titleize(art_song)}! ♪♪♪"
    start_screen
end

def genre_list
    genre_sort = Genre.order(:name)
    puts "♪♪♪ There is #{Genre.count} different genres in our files! ♪♪♪"
    genre_l = genre_sort.map do |genre|
        titleize(genre.name)
    end

    genre_info = PROMPT.select("Choose a genre for more info.", genre_l)
    searched_genres = Genre.find_by name: genre_info.downcase
    genr_art = searched_genres.artists.map {|artist| artist.name}.join(', ')

    puts "Here are the artists in the #{genre_info} genre: #{titleize(genr_art)}!"

    start_screen
end

def delete_song
    puts "Please enter the name of the song you would like to delete: "
    
    answer = gets.chomp.downcase

    if Song.find_by name: answer
       song_name = Song.find_by name: answer 
        song_name.destroy
        puts `clear`
        puts " The song is successfuly removed! "
    else 
        puts `clear`
        puts " ✘✘✘ These #{answer} does not exits on our file! ✘✘✘"
    end
    start_screen
end

def create_song
    puts `clear`
    puts "Please enter the name of the song you would like to create: "

    answer = gets.chomp.downcase

    Genre.all.each do |genre|
        puts titleize("#{genre.id.to_s}. #{genre.name}")
    end
    puts "Please enter genre id: "

    genre_answer = gets.chomp.downcase

    Artist.all.each do |artist|
        puts titleize("#{artist.name}") 
    end

     puts "Please enter artist name: "

     artist_answer = gets.chomp.downcase 

    
     artist_instance = Artist.find_or_create_by(name: artist_answer) 


    if Song.find_by name: answer
        song_name = Song.find_by name: answer
        puts "The song you enterd already exist. Try with some other song."
    else  
          Song.create name: answer, genre_id: genre_answer, artist_id: artist_instance.id
          puts `clear`
            puts "Song named #{answer.capitalize} is successfuly added to our playlist! ♪♪♪ Thank you! ♪♪♪"
    end
    puts `clear`
      start_screen      
end


def artist_most_songs
    a =  Artist.all.max_by(3) do |artist|
      artist.songs.count
     end

     a_name = a.map do |artist|
        artist.name 
     end

     puts "Artists with the most songs on our app are: #{a_name.join(', ').titleize}!"
     start_screen
end

def ganre_with_most_songs
    g = Genre.all.max_by do |genre|
        genre.artists.count
    end
    puts "The genre with the most songs on our app is #{g.name.titleize}!"
    start_screen
end



def main_screen


    5.times do 
        puts "                 ♫"
    end
puts "   ♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪"
puts "   ♪♪♪           👽           ♪♪♪"
puts "   ♪♪♪                        ♪♪♪"
puts "   ♪♪♪    MUSIC FOR LIFE      ♪♪♪"
puts "   ♪♪♪                        ♪♪♪"
puts "   ♪♪♪           🎸           ♪♪♪"
puts "   ♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪♪"


5.times do 
    puts "                 ♫"
end

3.times do
    puts "\n"
end



start_screen
end





main_screen

