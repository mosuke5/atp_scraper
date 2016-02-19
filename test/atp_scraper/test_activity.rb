require 'test_helper'

class TestActivity < Test::Unit::TestCase
  def setup
    # Test data is Novak Djokovic's activity in 2016
    # Australian open, Qatar
    html = File.open('test/atp_scraper/data/sample_activity.html').read
    html_charset = "utf-8"
    @activity = AtpScraper::Activity.new(html, html_charset)
  end

  def test_pickup_activity_data_first
    expected = {
      year: '2016',
      player_name: 'Novak Djokovic',
      player_rank: '1',
      opponent_name: 'Andy Murray',
      opponent_rank: '2',
      round: 'Finals',
      score: '61 75 763',
      win_loss: 'W',
      tournament_name: 'Australian Open',
      tournament_location: 'Melbourne, Australia',
      tournament_start_date: '2016.01.18',
      tournament_end_date: '2016.01.31',
      tournament_surface: 'OutdoorHard'
    }
    actual = @activity.pickup_activity_data.first
    assert_equal(actual, expected)
  end

  def test_pickup_activity_data_second
    expected = {
      year: '2016',
      player_name: 'Novak Djokovic',
      player_rank: '1',
      opponent_name: 'Roger Federer',
      opponent_rank: '3',
      round: 'Semi-Finals',
      score: '61 62 36 63',
      win_loss: 'W',
      tournament_name: 'Australian Open',
      tournament_location: 'Melbourne, Australia',
      tournament_start_date: '2016.01.18',
      tournament_end_date: '2016.01.31',
      tournament_surface: 'OutdoorHard'
    }
    actual = @activity.pickup_activity_data[1]
    assert_equal(actual, expected)
  end
end
