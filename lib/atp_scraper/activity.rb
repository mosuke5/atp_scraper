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

module AtpScraper
  # Scrape activity data
  class Activity
    def pickup_activity_data(activity_doc)
      result = []
      player = {}
      player[:name] = pickup_player_name(activity_doc)

      search_tournaments_doc(activity_doc).each do |tournament_doc|
        tournament = pickup_tournament_info(tournament_doc)
        player[:rank] = pickup_player_rank(tournament[:caption])
        search_records_doc(tournament_doc).each do |record_doc|
          record = pickup_record(record_doc)
          record_hash = create_record(record, player, tournament)
          result.push(record_hash)
        end
      end
      result
    end
    
    private

    def search_tournaments_doc(activity_doc)
      activity_doc.css(".activity-tournament-table")
    end

    def search_records_doc(tournament_doc)
      tournament_doc.css(".mega-table tbody tr")
    end

    def create_record(record, player, tournament)
      {
        year: tournament[:year],
        player_name: player[:name],
        player_rank: player[:rank],
        opponent_name: record[:opponent_name],
        opponent_rank: record[:opponent_rank],
        round: record[:round],
        score: record[:score],
        win_loss: record[:win_loss],
        tournament_name: tournament[:name],
        tournament_location: tournament[:location],
        tournament_start_date: tournament[:date][:start],
        tournament_end_date: tournament[:date][:end],
        tournament_surface: tournament[:surface]
      }
    end

    def pickup_player_name(activity_doc)
      activity_doc
        .css("meta[property=\"pageTransitionTitle\"]")
        .attr("content").value
    end

    def pickup_record(record_doc)
      result = {}
      record_doc.css("td").each_with_index do |td, n|
        record_content = td.content.strip
        case n
        when 0 then
          result[:round] = record_content
        when 1 then
          result[:opponent_rank] = record_content
        when 2 then
          result[:opponent_name] = record_content
        when 3 then
          result[:win_loss] = record_content
        when 4 then
          result[:score] = record_content
        end
      end
      result
    end

    def pickup_tournament_info(tournament_doc)
      tournament_date = pickup_text(tournament_doc, ".tourney-dates")
      {
        name: pickup_text(tournament_doc, ".tourney-title"),
        location: pickup_text(tournament_doc, ".tourney-location"),
        date: divide_tournament_date(tournament_date),
        year: tournament_date[0, 4],
        caption: pickup_text(tournament_doc, ".activity-tournament-caption"),
        surface: pickup_surface(tournament_doc)
      }
    end

    def pickup_player_rank(tournament_caption)
      rank = tournament_caption.match(/ATP Ranking:(.+), Prize/)
      rank[1].strip
    end

    # Before: String "2011.01.03 - 2011.01.08"
    # After:  Hash { start: 2011.01.03, end: 2011.01.08 }
    def divide_tournament_date(date)
      date = date.split('-').map(&:strip)
      { start: date[0], end: date[1] }
    end

    def pickup_text(doc, selector)
      doc.css(selector).first.content.strip
    end

    def pickup_surface(tournament_doc)
      tournament_doc
        .css(".tourney-details")[1]
        .css(".item-details")
        .first.content.gsub(/\t|\s/, "")
    end
  end
end
