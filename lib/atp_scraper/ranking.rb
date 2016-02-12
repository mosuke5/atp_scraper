## Structure Rnaking Page
# ranking_doc
#   player_doc
#   player_doc
#   player_doc
#   player_doc
#################

module AtpScraper
  # Scrape ranking data
  class Ranking
    class << self
      def get
        request_uri = "/en/rankings/singles"
        ranking_doc = AtpScraper::Html.get_and_parse(request_uri)
        pickup_ranking_data(ranking_doc)
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
          player_name: pickup_player_name(player_doc),
          player_url_name: get_url_name(url),
          player_id: get_url_id(url)
        }
      end

      def pickup_player_name(player_doc)
        player_doc.css(".player-cell").first.content.strip
      end

      def pickup_player_url(player_doc)
        player_doc.css(".player-cell a").attr("href").value
      end

      def get_url_name(url)
        url.split("/")[3]
      end

      def get_url_id(url)
        url.split("/")[4]
      end
    end
  end
end
