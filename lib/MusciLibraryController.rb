
require "pry"
class MusicLibraryController
  attr_accessor :path, :library

  def initialize(path="./db/mp3s")
    #binding.pry
    @path = path
    @library= MusicImporter.new(path).import
  end

  def call
    input = gets.strip
    if input != exit
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

    case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list_genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end

  end


  def list_songs           # Primitive Method
    raw_songs = [ ]
    @final_list = [ ]               #Optional, if wanted to collect all of the songs numbred and in order within an array
    @library.each do |song|
      raw_songs << song.split(" - ")[1]
    end
    ordered_songs= raw_songs.sort       #This first block collects the song titles and sorts them

    ordered_songs.map.with_index do |song, index|    #This second block uses the items and the indexes from the ordered_songs array and the indexes from the raw_songs array to collect (optional, if pushing into the "final_list array")) or print the orginial songs numbered and in order.
      if !@library[index].include? (song)
        value= raw_songs.index(song)
        @final_list << @library[value].gsub(".mp3","")
        puts "#{index+1}. #{@library[value].gsub(".mp3","")}"
      else
        @final_list << @library[index].gsub(".mp3","")
        puts "#{index+1}. #{@library[index].gsub(".mp3","")}"
      end
    end

  #  def list_songs                                                                  # Alternate method; better method
  #    Song.all.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
  #      puts "#{index+1}. #{song.name}"
  #    end
  #  end

  end

  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name }.each_with_index do | genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input =gets.strip
    found= Artist.all.detect {|artist| artist.name == input}
    if found
      found.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input =gets.strip
    found= Genre.all.detect {|genre| genre.name == input}
    if found
      found.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input =gets.strip.to_i
    if (1..Song.all.length).include?(input)
      new_array= Song.all.sort {|a, b| a.name <=> b.name}
      puts "Playing #{new_array[input-1].name} by #{new_array[input-1].artist.name}"
    end
  end


end
