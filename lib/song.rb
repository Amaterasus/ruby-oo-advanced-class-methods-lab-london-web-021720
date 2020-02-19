require 'pry'
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    @@all << song
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = self.new
    song.name = name
    @@all << song
    song
  end

  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    song = Song.find_by_name(name)
    if !song
      song = Song.create_by_name(name)
    end
    song
  end

  def self.alphabetical
    @@all.sort_by { |song| song.name}
  end

  def self.process_filename(filename)
    parts = filename.split(" - ")
    parts[1] = parts[1].split(".")
    parts.flatten
  end

  def self.new_from_filename(filename)
    parts = process_filename(filename)
    song = self.new
    song.name = parts[1]
    song.artist_name = parts[0]
    song
  end

  def self.create_from_filename(filename)
    parts = process_filename(filename)

    song = create_by_name(parts[1])
    
    song.artist_name = parts[0]
    song
  end

  def self.destroy_all
    @@all = []
  end
end
