module AtpScraper
  # Main class
  class Get
    def self.singles_ranking(rank_range = nil)
      request_uri = "/en/rankings/singles?rankRange=#{rank_range}"
      ranking_doc = AtpScraper::Html.get_and_parse(request_uri)
      ranking = AtpScraper::Ranking.new
      ranking.pickup_ranking_data(ranking_doc)
    end

    def self.player_activity(player_id, year)
      request_uri = "/players/anything/#{player_id}/player-activity?year=#{year}"
      activity_doc = AtpScraper::Html.get_and_parse(request_uri)
      activity = AtpScraper::Activity.new
      activity.pickup_activity_data(activity_doc)
    end
  end
end
