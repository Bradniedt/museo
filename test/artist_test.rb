require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'

class ArtistTest < Minitest::Test
  def setup
    attributes = {
                  id: "2",
                  name: "Ansel Adams",
                  born: "1902",
                  died: "1984",
                  country: "United States"
                  }
    @artist = Artist.new(attributes)
  end

  def test_it_exists
    assert_instance_of Artist, @artist
  end


end
