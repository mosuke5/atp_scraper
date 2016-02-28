module Activities
  # Activity Tournamnet Class
  class Tournament
    def initialize(doc)
      @tournament = doc
    end

    def info
      pickup_info(@tournament)
    end

    def records
      search_records_doc(@tournament)
    end

    private

    def pickup_info(tournament_doc)
      tournament_date = pickup_text(tournament_doc, ".tourney-dates")
      surface = pickup_surface(tournament_doc)
      caption = pickup_text(tournament_doc, ".activity-tournament-caption")
      {
        name: pickup_text(tournament_doc, ".tourney-title"),
        location: pickup_text(tournament_doc, ".tourney-location"),
        date: divide_tournament_date(tournament_date),
        year: tournament_date[0, 4],
        surface: surface[:surface],
        surface_inout: surface[:inout],
        ranking: pickup_player_rank(caption)
      }
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
      surface = tournament_doc
                .css(".tourney-details")[1]
                .css(".item-details")
                .first.content.gsub(/\t|\s/, "")
      divide_surface(surface)
    end

    def divide_surface(surface)
      inout = surface.match(/^(Outdoor|Indoor)/)
      return { surface: surface, inout: nil } if inout.nil?
      { surface: surface.gsub(/#{inout[0]}/, ''), inout: inout[0] }
    end

    def pickup_player_rank(tournament_caption)
      rank = tournament_caption.match(/ATP Ranking:(.+), Prize/)
      rank[1].strip
    end

    def search_records_doc(tournament_doc)
      tournament_doc.css(".mega-table tbody tr")
    end
  end
end
