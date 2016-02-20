module AtpScraper
  # Main class
  class Get
    def self.singles_ranking(rank_range = nil)
      request_uri = "/en/rankings/singles?rankRange=#{rank_range}"
      ranking_html = AtpScraper::Html.get(request_uri)
      ranking = AtpScraper::Ranking.new(ranking_html[:html], ranking_html[:charset])
      ranking.pickup_ranking_data
    end

    def self.player_activity(player_id, year)
      request_uri = "/players/anything/#{player_id}/player-activity?year=#{year}"
      activity_html = AtpScraper::Html.get(request_uri)
      activity = AtpScraper::Activity.new(activity_html[:html], activity_html[:charset])
      activity.pickup_activity_data
    end
  end
end
