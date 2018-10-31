class Curator
  attr_reader :artists,
              :photographs
  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      photo.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    artists = []
    artists_work = @artists.map do |artist|
      find_photographs_by_artist(artist)
    end
    artists_work.keep_if do |photos|
      photos.length > 1
    end.flatten!
    id = artists_work[0].artist_id
    artists << find_artist_by_id(id)
  end
end
