class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).select {|i| i.include?(".mp3")}
  end

  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
  
end
