class Photograph
  attr_reader :id,
              :name,
              :artist_id,
              :year
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @artist_id = data[:artist]
    @year = data[:year]
  end

end
