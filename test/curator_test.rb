require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/photograph'
require './lib/artist'
require './lib/curator'
require './lib/file_io'

class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new
    @artist_1 = Artist.new( {
                          id: "1",
                          name: "Henri Cartier-Bresson",
                          born: "1908",
                          died: "2004",
                          country: "France"
                          } )
    @artist_2 = Artist.new( {
                            id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"
                            } )
    @artist_3 = Artist.new( {
                            id: "3",
                            name: "Diane Arbus",
                            born: "1923",
                            died: "1971",
                            country: "United States"
                            } )
    @photo_1 = Photograph.new ( {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              } )
    @photo_2 = Photograph.new( {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
               } )
    @photo_3 = Photograph.new( {
                id: "3",
                name: "Identical Twins, Roselle, New Jersey",
                artist_id: "3",
                year: "1967"
              } )
    @photo_4 = Photograph.new( {
                id: "4",
                name: "Child with Toy Hand Grenade in Central Park",
                artist_id: "3",
                year: "1962"
               } )
    @photo_data = './data/photographs.csv'
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_its_artists_starts_empty
    assert_equal [], @curator.artists
  end

  def test_its_photographs_starts_empty
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    expected = [@photo_1, @photo_2]
    assert_equal expected, @curator.photographs
    assert_equal @photo_1, @curator.photographs.first
    assert_equal 'Rue Mouffetard, Paris (Boy with Bottles)', @curator.photographs.first.name
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    expected = [@artist_1, @artist_2]
    assert_equal expected, @curator.artists
    assert_equal @artist_1, @curator.artists.first
    assert_equal 'Henri Cartier-Bresson', @curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id('1')
  end

  def test_it_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_2, @curator.find_photograph_by_id('2')
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    diane_arbus = @curator.find_artist_by_id('3')
    expected = [@photo_3, @photo_4]
    assert_equal expected, @curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_can_find_all_artists_with_multiple_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_it_can_find_photographs_by_artists_from_a_specific_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    expected = [@photo_2, @photo_3, @photo_4]
    actual = @curator.photographs_taken_by_artists_from("United States")
    assert_equal expected, actual
    assert_equal [], @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_load_photographs_from_csv_file
    @curator.load_photographs(@photo_data)
    assert_equal 4, @curator.photographs.length
  end

  def test_it_can_load_artists_from_csv_file
    @curator.load_artists(@artist_data)
    assert_equal 6, @curator.artists.length
  end
end
