require 'test_helper'

class TestRanking < Test::Unit::TestCase
  # sample data ranking
  # 1, Novak Djokovic
  # 2, Andy Murray
  # 3, Roger Federer
  # 4, Stan Wawrinka
  # 5, Rafael Nadal
  def setup
    @html = File.open('test/atp_scraper/data/sample_ranking.html').read
    @html_charset = "utf-8"
    @ranking = AtpScraper::Ranking
    @ranking_doc = AtpScraper::Html.parse(@html, @html_charset)
    @player_doc = @ranking.search_player_doc(@ranking_doc).first
  end

  def test_pickup_ranking_data_no1
    expect = {
      ranking: '1',
      player_name: 'Novak Djokovic',
      player_url_name: 'novak-djokovic',
      player_id: 'd643'
    }
    actual = @ranking.pickup_ranking_data(@ranking_doc).first
    assert_equal(actual, expect)
  end

  def test_pickup_ranking_data_no5
    expect = {
      ranking: '5',
      player_name: 'Rafael Nadal',
      player_url_name: 'rafael-nadal',
      player_id: 'n409'
    }
    actual = @ranking.pickup_ranking_data(@ranking_doc)[4]
    assert_equal(actual, expect)
  end
  
  def test_pickup_player_url
    expect = "/en/players/novak-djokovic/d643/overview"
    actual = @ranking.pickup_player_url(@player_doc)
    assert_equal(actual, expect)
  end

  def test_get_url_name
    expect = "novak-djokovic"
    url = @ranking.pickup_player_url(@player_doc)
    actual = @ranking.get_url_name(url)
    assert_equal(actual, expect)
  end
end

