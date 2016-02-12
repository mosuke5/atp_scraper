require 'test_helper'

class TestAtpScraper < Test::Unit::TestCase

  def setup
    # Test data is RafaelNadal's activity in 2012
    # http://www.atpworldtour.com/players/rafael-nadal/n409/player-activity?year=2012
    @html = File.open('test/atp_scraper/data/sample.html').read
    @html_charset = "utf-8"
    @activity = AtpScraper::Activity
    @activity_doc = AtpScraper::Html.parse(@html, @html_charset)

    # Wimbledon tournament data
    @tournament_doc = @activity.search_tournaments_doc(@activity_doc).first
    @tournament_info = @activity.pickup_tournament_info(@tournament_doc)

    # VS Rosol data in Wimbledon
    @record_doc = @activity.search_records_doc(@tournament_doc).first
  end

  def test_pickup_player_name
    expect = 'Rafael Nadal'
    assert_equal(
      @activity.pickup_player_name(@activity_doc),
      expect
    )
  end

  def test_pickup_tournament_info
    expect = {
      name: 'Wimbledon',
      location: 'London, Great Britain',
      date: { start: '2012.06.25', end: '2012.07.08' },
      year: '2012',
      caption: 'This Event Points: 45, ATP Ranking: 2, Prize Money: £23,125',
      surface: 'OutdoorGrass'
    }
    assert_equal(
      @activity.pickup_tournament_info(@tournament_doc),
      expect
    )
  end

  def test_pickup_pleyer_rank
    expect = '2'
    assert_equal(
      @activity.pickup_player_rank(@tournament_info[:caption]),
      expect
    )
  end

  def test_pickup_record
    expect = {
      round: 'Round of 64',
      opponent_rank: '100',
      opponent_name: 'Lukas Rosol',
      win_loss: 'L',
      score: '769 46 46 62 46'
    }
    assert_equal(
      @activity.pickup_record(@record_doc),
      expect
    )
  end

  def test_pickup_surface
    expect = 'OutdoorGrass'
    assert_equal(
      @activity.pickup_surface(@tournament_doc),
      expect
    )
  end

  def test_divide_tournament_date
    actual = '2011.01.03 - 2011.01.08'
    expect = { start: '2011.01.03', end: '2011.01.08' }
    assert_equal(
      @activity.divide_tournament_date(actual),
      expect
    )
  end
end
