require 'test_helper'

class TestActivity < Test::Unit::TestCase

  def setup
    # Test data is Novak Djokovic's activity in 2016
    # Australian open, Qatar
    @html = File.open('test/atp_scraper/data/sample_activity.html').read
    @html_charset = "utf-8"
    @activity = AtpScraper::Activity
    @activity_doc = AtpScraper::Html.parse(@html, @html_charset)

    # Australian Open Tournament
    @tournament_doc = @activity.search_tournaments_doc(@activity_doc).first
    @tournament_info = @activity.pickup_tournament_info(@tournament_doc)

    # Australian Open Final vs A.Murray record
    @record_doc = @activity.search_records_doc(@tournament_doc).first
  end

  def test_pickup_player_name
    expect = 'Novak Djokovic'
    actual = @activity.pickup_player_name(@activity_doc)
    assert_equal(actual, expect)
  end

  def test_pickup_tournament_info
    expect = {
      name: 'Australian Open',
      location: 'Melbourne, Australia',
      date: { start: '2016.01.18', end: '2016.01.31' },
      year: '2016',
      caption: 'This Event Points: 2000, ATP Ranking: 1, Prize Money: A$3,400,000',
      surface: 'OutdoorHard'
    }
    actual = @activity.pickup_tournament_info(@tournament_doc)
    assert_equal(actual, expect)
  end

  def test_pickup_pleyer_rank
    expect = '1'
    actual = @activity.pickup_player_rank(@tournament_info[:caption])
    assert_equal(actual, expect)
  end

  def test_pickup_record
    expect = {
      round: 'Finals',
      opponent_rank: '2',
      opponent_name: 'Andy Murray',
      win_loss: 'W',
      score: '61 75 763'
    }
    actual = @activity.pickup_record(@record_doc)
    assert_equal(actual, expect)
  end

  def test_pickup_surface
    expect = 'OutdoorHard'
    actual = @activity.pickup_surface(@tournament_doc)
    assert_equal(actual, expect)
  end

  def test_divide_tournament_date
    expect = { start: '2011.01.03', end: '2011.01.08' }
    data = '2011.01.03 - 2011.01.08'
    actual = @activity.divide_tournament_date(data)
    assert_equal(actual, expect)
  end
end
