require "pry"

class Song
  attr_accessor :name, :artist, :genre

  @@all = [ ]

  def initialize(name, artist=nil, genre=nil)   # The "instance_variable= nil" makes the variable optional upon initialization of new object.
    @name = name
    self.artist=(artist) if artist != nil #-->"self.artist=" is NOT the same as "@artist=";
    self.genre=(genre) if genre != nil       # "self.artist=" invokes a setter method that, in addition to
  end                                        # setting the instance variable "@artist" equal to the
                                             # argument "artist", it sets the "song.artist" property of
  def self.all                               # the newly created song object equal to an artist object AND adds
    @@all                                    # the newly created song object to the artist object's "@songs" array.
  end                                        # via collaboration between the Song class and the Artist class,
                                             # that begings in the Song class "artist=" setter method and
  def save                                   # ends in the Arist class "add_song" method.
    @@all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    new_instance = self.new(name)
    new_instance.save
    new_instance
  end

  def artist
    #self.artist    [This line creates an infinite loop because "self.artist" calls its defining method again]
    @artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
     @genre = genre
     genre.add_song(self)
    # genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    found = self.find_by_name(name)
    if found
      found
    else
      self.create(name)
    end
  end

  def self.new_from_filename(filename)
  #  binding.pry
  #  song= Song.new(filename)
    song_name = filename.split(" - ")[1]
    song_artist = filename.split(" - ")[0]
    song_genre = filename.split(" - ")[2].gsub(".mp3","")

    artist = Artist.find_or_create_by_name(song_artist)
    genre = Genre.find_or_create_by_name(song_genre)
    song = Song.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

end
