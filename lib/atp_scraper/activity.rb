## Page Structure
# activity_doc(whole)
#   tournament_doc
#     record_doc
#     record_doc
#     record_doc
#     record_doc
#   tournament_doc
#     record_doc
#     record_doc
#     record_doc
###################

require 'atp_scraper/activities/record'
require 'atp_scraper/activities/tournament'
module AtpScraper
  # Scrape activity data
  class Activity
    include Activities
    def initialize(html, html_charset = 'utf-8')
      @activity_doc = AtpScraper::Html.parse(html, html_charset)
      @player_name = pickup_player_name
    end

    def pickup_activity_data
      result = []

      search_tournaments_doc.each do |tournament_doc|
        tournament = Tournament.new(tournament_doc)
        tournament.records.each do |record_doc|
          record = Record.new(record_doc)
          record_hash = create_record(record.get, tournament.get)
          result.push(record_hash)
        end
      end
      result
    end

    private

    def search_tournaments_doc
      @activity_doc.css(".activity-tournament-table")
    end

    def create_record(record, tournament)
      {
        year: tournament[:year],
        player_name: @player_name,
        player_rank: tournament[:ranking],
        opponent_name: record[:opponent_name],
        opponent_rank: record[:opponent_rank],
        round: record[:round],
        score: record[:score],
        win_loss: record[:win_loss],
        tournament_name: tournament[:name],
        tournament_category: tournament[:category],
        tournament_location: tournament[:location],
        tournament_start_date: tournament[:date][:start],
        tournament_end_date: tournament[:date][:end],
        tournament_surface: tournament[:surface],
        tournament_surface_inout: tournament[:surface_inout]
      }
    end

    def pickup_player_name
      @activity_doc
        .css("meta[property=\"pageTransitionTitle\"]")
        .attr("content").value
    end
  end
end
