module Activities
  # Activity Tournamnet Class
  class Tournament
    def initialize(doc)
      @tournament = doc
    end

    # Return tournament data
    def get
      tournament_date = pickup_text(".tourney-dates")
      surface = pickup_surface
      caption = pickup_text(".activity-tournament-caption")
      {
        name: pickup_text(".tourney-title"),
        category: pickup_category,
        location: pickup_text(".tourney-location"),
        date: divide_tournament_date(tournament_date),
        year: tournament_date[0, 4],
        surface: surface[:surface],
        surface_inout: surface[:inout],
        ranking: pickup_player_rank(caption)
      }
    end
    
    # Return records in this tournament
    def records
      @tournament.css(".mega-table tbody tr")
    end

    private

    # Before: String "2011.01.03 - 2011.01.08"
    # After:  Hash { start: 2011.01.03, end: 2011.01.08 }
    def divide_tournament_date(date)
      date = date.split('-').map(&:strip)
      { start: date[0], end: date[1] }
    end

    def pickup_text(selector)
      @tournament.css(selector).first.content.strip
    end

    def pickup_category
      # ex) /~/media/images/tourtypes/categorystamps_itf_118x64.png?xxxxx
      badge_url = @tournament.css(".tourney-badge-wrapper img").attr("src").value
      badge_url.match(/categorystamps_(.*)_[0-9]*x[0-9]*.png/)[1]
    end

    def pickup_surface
      surface = @tournament
                .css(".tourney-details")[1]
                .css(".item-details")
                .first.content.gsub(/\t|\s/, "")
      divide_surface(surface)
    end
    
    # "OutdoorHard" => { surface: "Hard", inout: "Outdoor" } 
    def divide_surface(surface)
      inout = surface.match(/^(Outdoor|Indoor)/)
      return { surface: surface, inout: nil } if inout.nil?
      { surface: surface.gsub(/#{inout[0]}/, ''), inout: inout[0] }
    end

    def pickup_player_rank(tournament_caption)
      rank = tournament_caption.match(/ATP Ranking:(.+), Prize/)
      rank[1].strip
    end
  end
end
