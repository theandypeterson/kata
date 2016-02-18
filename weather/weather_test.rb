$LOAD_PATH << "."

require 'minitest/autorun'
require 'weather.rb'

class WeatherTest < Minitest::Test

  def test_calc_spread
    assert_raises() { Weather.calc_spread("asdf","asdf") }
    assert_equal 1, Weather.calc_spread(-1, -2)
    assert_equal 0, Weather.calc_spread(0,0)
    assert_equal 1, Weather.calc_spread(1,0)
    assert_equal 1, Weather.calc_spread(2,1)
    assert_equal 1, Weather.calc_spread(1,2)
    assert_equal 5, Weather.calc_spread(10,5)
    assert_equal 5, Weather.calc_spread(5,10)
  end

  def test_read_file_with_nil_filename
    assert_raises() { Weather.read_file(nil) }
  end

  def test_read_non_existent_file
    assert_raises() { Weather.read_file("where_am_i.txt") }
  end

  def test_read_empty_file
    weather_data = Weather.read_file("empty.txt")
    assert_equal 0, weather_data.size
  end

  def test_read_file_with_30_data_points
    weather_data = Weather.read_file('weather.dat')
    assert_equal 30, weather_data.size
  end

  def test_read_file_with_nonsense
    weather_data = Weather.read_file('nonsense.txt')
    assert_equal 0, weather_data.size
  end

  def test_empty_line_does_not_have_valid_data
    line = []
    refute Weather.line_has_valid_data?(line)
  end

  def test_invalid_line_does_not_have_valid_data
    line = ["Day", "Max", "Min", "Etc"]
    refute Weather.line_has_valid_data?(line)
  end

  def test_valid_line_has_valid_data
    line = ["1", "2", "3", "Etc"]
    assert Weather.line_has_valid_data?(line)
  end

  def test_processed_data
    lines = [["1", "11", "111", "1111", "etc"],
             ["2", "22", "222", "2222", "etc"],
             ["3", "33", "333", "3333", "etc"]]
    processed_data = { '1' => { max: 11, min: 111, spread: 100 },
                       '2' => { max: 22, min: 222, spread: 200 },
                       '3' => { max: 33, min: 333, spread: 300 }}
    assert_equal processed_data, Weather.get_data_from_file(lines)
  end

  def test_get_min_spread
    processed_data = { '1' => { max: 11, min: 111, spread: 100 },
                       '2' => { max: 22, min: 222, spread: 200 },
                       '3' => { max: 33, min: 333, spread: 300 }}
    day_with_lowest_spread = [ '1', { max: 11, min: 111, spread: 100 }]
    assert_equal day_with_lowest_spread, Weather.find_lowest_spread(processed_data)
  end
  
  def test_get_min_spread_with_tie
    processed_data = { '1' => { max: 11, min: 111, spread: 100 },
                       '2' => { max: 22, min: 222, spread: 100 },
                       '3' => { max: 33, min: 333, spread: 300 }}
    day_with_lowest_spread = [ '1', { max: 11, min: 111, spread: 100 }]
    assert_equal day_with_lowest_spread, Weather.find_lowest_spread(processed_data)
  end



end
