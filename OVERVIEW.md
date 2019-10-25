Music app Project


###Installing
1. Fork the lab from github.
2. Open the folder where you want the lab and clone it.
3. Open the lab in studio.

###Running

1. Don't forget 'bundle install' in your terminal
2. To run the app you must type in "ruby bin/run.rb" in your terminal

==========================================================


Music app is here to store yoiur music data and information about songs, artists and genres.
You can create, add, change or delete songs and artists. 


===========================================================

Into the gemfile I added gem 'tty-prompt' to make it easeir for users. This will help you go thru the menu only with using up and down arrows on keybord. 

===========================================================

1. Wild card search (song, artist or genre)
- this option is use to search for any of these above.

2. Search for song
- search for song by any word in the title.

3. Search for artist
- search for an artist by any word in their name.


4. List of songs
- this option will provide user with the list of songs. Songs are clickable so you can see more info about the song you choose.

5. List of artists
- this option will provide user with the list of artists. Artists are clickable so you can see more info about the artist you choose.

6. List of genres
- this option will provide user with the list of genres. Genres are clickable so you can see more info about the genre you choose.

7. Create and add song
- this option will give user a chance to create and add song. User must choose from ganre by id (genres will be listed with the id) and add the song to an artist or just simply create new one.

8. Delete song
- this gives a user option to delete song.

9. Main screen
- will open the main screen again.

10. TOP 3 artists
- this will show to user top 3 artists with the most songs on our app

11. Most popular genre
- this will show you the genre with most songs in it on our app

12. Quit
- this option will ask user for an input. User will need to answer simpy yes or no (Y/N)