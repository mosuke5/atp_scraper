## Structure Rnaking Page
# ranking_doc
#   no1. player_doc
#   no2. player_doc
#   no3. player_doc
#   no4. player_doc
#################

module AtpScraper
  # Scrape ranking data
  class Ranking
    def initialize(html, html_charset = 'utf-8')
      @ranking_doc = AtpScraper::Html.parse(html, html_charset)
    end

    def pickup_ranking_data
      result = []
      search_player_doc(@ranking_doc).each do |player_doc|
        result.push(pickup_player_data(player_doc))
      end
      result
    end

    private

    def search_player_doc(ranking_doc)
      ranking_doc.css(".mega-table tbody tr")
    end

    def pickup_player_data(player_doc)
      url = pickup_player_url(player_doc)
      {
        ranking: pickup_player_rank(player_doc),
        player_name: pickup_player_name(player_doc),
        player_url_name: get_url_name(url),
        player_id: get_url_id(url),
        points: pickup_player_points(player_doc)
      }
    end

    def pickup_player_rank(player_doc)
      player_doc.css(".rank-cell").first.content.strip
    end

    def pickup_player_name(player_doc)
      player_doc.css(".player-cell").first.content.strip
    end

    def pickup_player_url(player_doc)
      player_doc.css(".player-cell a").attr("href").value
    end

    # points: '5,000'(in html) => '5000'
    def pickup_player_points(player_doc)
      player_doc.css(".points-cell").first.content.strip.delete(',')
    end

    # url => "/en/players/rafael-nadal/n409/overview"
    def get_url_name(url)
      url.split("/")[3]
    end

    def get_url_id(url)
      url.split("/")[4]
    end
  end
end
