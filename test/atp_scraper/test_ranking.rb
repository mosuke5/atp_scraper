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
    @ranking = AtpScraper::Ranking.new
    @ranking_doc = AtpScraper::Html.parse(@html, @html_charset)
  end

  def test_pickup_ranking_data_no1
    expected = {
      ranking: '1',
      player_name: 'Novak Djokovic',
      player_url_name: 'novak-djokovic',
      player_id: 'd643'
    }
    actual = @ranking.pickup_ranking_data(@ranking_doc).first
    assert_equal(actual, expected)
  end

  def test_pickup_ranking_data_no5
    expected = {
      ranking: '5',
      player_name: 'Rafael Nadal',
      player_url_name: 'rafael-nadal',
      player_id: 'n409'
    }
    actual = @ranking.pickup_ranking_data(@ranking_doc)[4]
    assert_equal(actual, expected)
  end
end
