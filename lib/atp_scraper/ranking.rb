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
    class << self
      def get(rank_range = nil)
        request_uri = build_uri(rank_range) 
        ranking_doc = AtpScraper::Html.get_and_parse(request_uri)
        pickup_ranking_data(ranking_doc)
      end

      def build_uri(rank_range = "0-100")
        "/en/rankings/singles?rankRange=#{rank_range}"
      end

      def pickup_ranking_data(ranking_doc)
        result = []
        search_player_doc(ranking_doc).each do |player_doc|
          result.push(pickup_player_data(player_doc))
        end
        result
      end

      def search_player_doc(ranking_doc)
        ranking_doc.css(".mega-table tbody tr")
      end

      def pickup_player_data(player_doc)
        url = pickup_player_url(player_doc)
        {
          ranking: pickup_player_rank(player_doc),
          player_name: pickup_player_name(player_doc),
          player_url_name: get_url_name(url),
          player_id: get_url_id(url)
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

      # url => "/en/players/rafael-nadal/n409/overview"
      def get_url_name(url)
        url.split("/")[3]
      end

      def get_url_id(url)
        url.split("/")[4]
      end
    end
  end
end
