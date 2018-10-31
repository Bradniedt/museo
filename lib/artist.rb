class Artist
  attr_reader :id,
              :name,
              :born,
              :died,
              :country
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @born= data[:born]
    @died = data[:died]
    @country = data[:country]
  end

end
