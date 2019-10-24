require 'faker'

10.times do 
    Artist.create(name: Faker::Music.band.downcase)
    Genre.create(name: Faker::Music.genre.downcase)
end

10.times do
    Song.create(name: Faker::Music::GratefulDead.song.downcase, artist_id: rand(1..10), genre_id: rand(1..10))
end

puts "seed completed"
puts "#{Artist.count} artists created!"
puts "#{Genre.count} genres created!"
puts "#{Song.count} songs created!"